# Task 8
# Class CargoTrain
require_relative 'validation.rb'

class CargoTrain < Train
  include Validation  
  
  validate :num, :format, NUM_FORMAT
  validate :num, :presence

  def initialize(num)
    super
    validate!
  end

  protected

  def type_validation?(carriage)
    carriage.class == CargoCarriage
  end
end
