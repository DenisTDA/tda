# Task 8
# Class PassengerTrain 
require_relative 'validation.rb'

class PassengerTrain < Train
  include Validation
  
  validate :num, :format, NUM_FORMAT
  validate :num, :presence

  def initialize(num)
    super
    validate!
  end

  protected

  def type_validation?(carriage)
    carriage.class == PassengerCarriage
  end
end
