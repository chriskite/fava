require 'beanstalk-client'

class BeanstalkServer < DelegateClass(Beanstalk::Pool)
  def initialize
    super(Beanstalk::Pool.new(["#{$BEANSTALK_HOST}:11300"]))
  end

end
