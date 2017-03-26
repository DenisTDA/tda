#Разделить поезда на два типа PassengerTrain и CargoTrain, сделать родителя для классов, 
#который будет содержать общие методы и свойства
class PassengerTrain < Train
  private
  def set_type
    @type = :passenger
  end
end