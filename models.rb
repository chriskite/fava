require 'beanstalk-client'

class BeanstalkServer < DelegateClass(Beanstalk::Pool)
  def initialize
    super(Beanstalk::Pool.new(["vertjosh.dev:11300"]))
  end

end
