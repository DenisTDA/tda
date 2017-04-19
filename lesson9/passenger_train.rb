# Task 8
# Class PassengerTrain 
class PassengerTrain < Train
  protected

  def type_validation?(carriage)
    carriage.class == PassengerCarriage
  end
end
