require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'compass'
require File.dirname(__FILE__) + '/app'
path = ''

$BEANSTALK_HOST='localhost'

set :root, path
set :views, path + 'views'
set :public,  path + 'public'
set :run, false
set :environment, :development
set :raise_errors, true

Compass.configuration do |config|
config.project_path = File.dirname(__FILE__)
config.sass_dir = 'views/stylesheets'
end

set :haml, { :format => :html5 }
set :sass, Compass.sass_engine_options


log = File.new("sinatra.log", "a")
#STDOUT.reopen(log)
#STDERR.reopen(log)

run Sinatra::Application
