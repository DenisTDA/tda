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
  @@count_tr=0
  attr_accessor :station, :speed, :route 
  attr_reader :carriages

  def initialize(num, type, carriages=0)
    @num, @type, @carriages = num, type, carriages
    @@count_tr+= 1
    @speed = 0.0
    @route = []
    @station = 0
  end


  def increase_speed(increment)
    @speed+=increment
  end


  def decrease_speed(decr)
    if @speed >=decr 
      self.speed= @speed - decr
    else
      self.speed = 0
    end
  end

  def carriage_add
    @carriages+= 1 if @speed == 0
  end

  def carriage_del
    @carriages-= 1 if @speed == 0 && self.carriages!=0
  end

  def set_route(route)
    self.route = route.stations
    self.speed = 0
    self.station = 0
  end

  def current_station
    @route[@station]
  end

  def move_forward
    if @station+1 != @route.length
      self.station = @station + 1
    else
      return self.station
    end
  end

  def move_back
    if @station != 0
      self.station = @station - 1
    else
      return self.station
    end
  end

  def previus_station
    @route[self.station - 1]
  end

  def next_station
    @route[self.station + 1]
  end
end