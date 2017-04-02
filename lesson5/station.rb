=begin
4.  
Класс Station (Станция):
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
5.
В классе Station (жд станция) создать метод класса all, который возвращает все станции (объекты), созданные на данный момент 
=end
# require_relative 'instance_counter.rb'

class Station
 include InstanceCounter

  @@all_stations = []
  attr_reader :trains,:name

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
    register_instance    
  end

  def take_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.count {|train| train.type == type}
  end

  def send_train(train)
    @trains.delete(train) 
  end
end