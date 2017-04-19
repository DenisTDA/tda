# Task 8
# Class CargoTrain
class CargoTrain < Train
  protected

  def type_validation?(carriage)
    carriage.class == CargoCarriage
  end
end
