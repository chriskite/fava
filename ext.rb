class Beanstalk::Job
  def to_ary
    {:id => id,
     :body => body,
     :age => age}
  end
end
