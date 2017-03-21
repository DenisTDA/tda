=begin
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
=end  

class Train
 
  attr_accessor :speed, :station_index, :route
  attr_reader :carriages, :type 

  def initialize(num, type, carriages=0)
    @num, @type, @carriages = num, type, carriages
    @speed = 0
  end


  def increase_speed(increment)
    @speed += increment
  end


  def decrease_speed(decr)
    if @speed >=decr 
      @speed -= decr
    else
      self.speed = 0
    end
  end

  def carriage_add
    @carriages+= 1 if @speed == 0
  end

  def carriage_del
    @carriages-= 1 if @speed == 0 && @carriages>0
  end

  def set_route(route)
    self.route = route
    self.speed = 0
    self.station_index = 0
    @route.stations[0].take_train(self)
  end

  def current_station
    @route.stations[station_index] if self.route 
  end

  def move_forward
    if @route.stations.length > @station_index+1
      current_station.send_train(self)
      @station_index += 1
      current_station.take_train(self)
    else
      return @station_index
    end
  end

  def move_back
    if @station_index > 0
      current_station.send_train(self)
      @station_index -= 1
      current_station.take_train(self)
    else
      return @station_index
    end
  end

  def previus_station
    @route.stations[@station_index - 1] if station_index>0
  end

  def next_station
    @route.stations[@station_index + 1] if @route.stations.length > @station_index + 1
  end
end