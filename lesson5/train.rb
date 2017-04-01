=begin
4.
Класс Train (Поезд):
Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
Может набирать скорость
Может возвращать текущую скорость
Может тормозить (сбрасывать скорость до нуля)
Может возвращать количество вагонов
Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). 
    Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
Может принимать маршрут следования (объект класса Route). 
При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
5.
-Подключить модуль к классам Вагон и Поезд
-Добавить к поезду атрибут Номер (произвольная строка), если его еще нет, который указыватеся при его создании
-В классе Train создать метод класса find, который принимает номер поезда (указанный при его создании) 
  и возвращает объект поезда по номеру или nil, если поезд с таким номером не найден.
=end  
require_relative 'manufacturer.rb'

class Train
  include Manufacturer
  @@all_trains = {}

  attr_reader :carriages,  :route, :speed, :num 

  def initialize(num)
    @num = num
    @speed = 0
    @carriages = []
    @@all_trains[num] = self
  end

  def self.find(number_train)
    @@all_trains[number_train]
  end

  def up_speed(increment=1)
    @speed += increment
  end


  def down_speed(decr=1)
    if @speed >=decr 
      @speed -= decr
    else
      stop!
    end
  end

  def carriage_add(car)
    @carriages << car if stoped? && type_validation?(car)
  end

  def carriage_del
    @carriages.pop if stoped? && not_empty?
  end

  def set_route(route)
    self.route = route
    stop!
    self.station_index = 0
    @route.stations[0].take_train(self)
  end

  def current_station
    @route.stations[station_index] if self.route 
  end

  def move_forward
    if not_last?
      current_station.send_train(self)
      @station_index += 1
      current_station.take_train(self)
    else
      return @station_index
    end
  end

  def move_back
    if not_first?
      current_station.send_train(self)
      @station_index -= 1
      current_station.take_train(self)
    else
      return @station_index
    end
  end

  def previus_station
    @route.stations[previus!] if not_first?
  end

  def next_station
    @route.stations[next!] if not_last?
  end

  protected
  def type_validation?(carriage)
  end

  private
  attr_accessor :station_index
  attr_writer :route, :speed

  def not_empty?
    @carriages.length>0
  end

  def stop!
    self.speed = 0
  end

  def stoped?
    @speed.zero?
  end

  def not_last?
    @route.stations.length > @station_index+1
  end

  def not_first?
    station_index>0
  end

  def next!
    @station_index + 1
  end

  def pevius!
    @station_index - 1
  end
end