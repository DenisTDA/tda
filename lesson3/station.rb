=begin
  
Класс Station (Станция):
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
 
=end

class Station
  attr_accessor :name
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = {}
  end

  def take_train(num, type)
    @trains[num]= type
  end

  def trains_by_type(type_filter)
    count=0
    @trains.each_value {|type| count+= 1 if type == type_filter}
    return count
  end

  def send_train(num)
    @trains.delete(num) 
  end
end