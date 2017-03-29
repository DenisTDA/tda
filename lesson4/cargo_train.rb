#Разделить поезда на два типа PassengerTrain и CargoTrain, сделать родителя для классов, 
#который будет содержать общие методы и свойства
class CargoTrain < Train

  def carriage_add(car=CargoCarriage.new)
    super
  end
end