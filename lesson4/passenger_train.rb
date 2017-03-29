#Разделить поезда на два типа PassengerTrain и CargoTrain, сделать родителя для классов, 
#который будет содержать общие методы и свойства
class PassengerTrain < Train

  def carriage_add(car=PassengerCarriage.new)
    super
  end
end