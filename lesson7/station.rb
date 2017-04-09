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
7.
У класса Station:
написать метод, который принимает блок и проходит по всем поездам на станции, 
передавая каждый поезд в блок.
=end
require_relative 'instance_counter.rb'

class Station
 include InstanceCounter

  NAME_FORMAT = /^([a-z|\d]){3,25}$/i
  LENGTH_NAME = 3
  @@all_stations = []
  attr_reader :trains,:name

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    validate_name!
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

  def valid?(name)
    validate_name!
  rescue => e
    puts "Error!!! ==> #{e.message}"
    false
  end

  def each_train(&block)
    @trains.each{ |train| block.call(train)}
  end


  private
  def validate_name!
    raise "Error name! FormatError!!! FORMAT ==>[a-z0-9]==> X{3,15}" if @name !~ NAME_FORMAT
    true
  end
end