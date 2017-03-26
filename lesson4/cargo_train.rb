#Разделить поезда на два типа PassengerTrain и CargoTrain, сделать родителя для классов, 
#который будет содержать общие методы и свойства
class CargoTrain < Train
  private
  def set_type
    @type = :cargo
  end
end