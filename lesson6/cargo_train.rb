#Разделить поезда на два типа PassengerTrain и CargoTrain, сделать родителя для классов, 
#который будет содержать общие методы и свойства
class CargoTrain < Train

  protected
  def type_validation?(carriage)
    carriage.class == CargoCarriage
  end
end