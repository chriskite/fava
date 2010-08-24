require 'rubygems'
require 'sinatra'
require './models'
require './ext'
require 'json'

helpers do
  def pretty_hash(hash)
    hash.to_a.map { |arr| [arr[0].tr('-', ' ').capitalize, arr[1]] }.inject({}) { |r, v| r[v[0]] = v[1]; r }
  end
end

get '/' do
  server = BeanstalkServer.new
  @header = 'Fava - Beanstalk Stats for localhost'
  @stats = server.stats
  @tubes = server.list_tubes.values.first
  @tube_stats = @tubes.inject({}) { |r, tube| r[tube] = server.stats_tube(tube); r }

  haml :index
end

get '/tube/:tube' do
  server = BeanstalkServer.new
  @tube = params[:tube]
  @header = "Fava - Tube '#{@tube}'"
  @tube_stats = server.stats_tube(@tube)

  haml :tube
end

get '/tube/:tube/buried' do
  content_type :json

  server = BeanstalkServer.new
  @tube = params[:tube]
  server.use(@tube.to_sym)

  @buried = server.peek_buried
  if !@buried.nil?
    return @buried.to_ary.merge({:status => true}).to_json
  end

  {:status => false}.to_json
end

get '/stylesheets/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass(:"stylesheets/#{params[:name]}", Compass.sass_engine_options )
end

