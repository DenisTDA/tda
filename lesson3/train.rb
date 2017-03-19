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
  attr_reader :cars

  def initialize(num, type, cars=0)
    @num, @type, @cars = num, type, cars
    @@count_tr+= 1
    @speed = 0.0
    @route = []
    @station = ""
  end

# увеличить скорость
  def incr_sp (incr)
    @speed+=incr
    return @speed    
  end

#Уменьшить скорость
  def decr_sp (decr)
    if self.speed >=decr 
      @speed-= decr
      else
      self.speed = 0
    end
    return @speed
  end

#проверка стоит/едет
  def status_speed
    if self.speed >0 
      puts "Состав в движении"
      return true
    else
      return false
    end
  end

#добавление вагона к составу
  def car_add
    @cars+= 1 if !status_speed
  end

#удаление вагона из состава
  def car_del
    @cars-= 1 if !status_speed && self.cars!=0
  end

#получает маршрут, устанавливает скорость в нуль и помещаем состав на начальную станцию
  def set_route (route)
    self.route = route.stations
    self.speed = 0
    self.station = @route[0]
  end

#на 1 станцию вперед
  def move_f
    if @station != @route.last
      index_c = @route.index(@station)
      self.station = @route[index_c+1]
    else
      puts "Конечная станция!"
      return self.station
    end
  end

#вернутся на 1 станцию
  def move_b
    if @station != @route.first
      index_c = @route.index(@station)
      self.station = @route[index_c-1]
    else
      puts "Начальная станция!"
    end
  end

#возвращать предыдущую станцию
  def last_st
    index_c = @route.index(@station)
    last_st = @route[index_c-1]
    return last_st
  end

#взвращать следующую станцию
  def next_st
    index_c = @route.index(@station)
    next_st = @route[index_c+1]
    return next_st
  end
end