class CachingController < ApplicationController
  
  def basic
  end
  
  def with_instance_variables
    @sample = Sample.create!
    @unused_sample = Sample.create!
  end

end