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
  @@stations=[]
  def initialize(name)
    @name = name
    @@stations << name
    @trains = {}
  end
#Принять поезд на станцию
  def get_tr (num, type)
    @trains [num]= type
    puts "Поезд #{num} #{type} добавлен" 
  end
#вывод списка всех поездов на станции
  def list_tr
    @trains.each {|num, type| puts "Номер поезда:\t#{num}\t ||\tтип состава:\t#{type} "}
  end
#выводе списка поездов по типу (грузовой/пассажирский)
  def type_tr (type_tr)
    count=0
    @trains.each_value {|type| count+= 1 if type == type_tr}
    puts "Количество составов - #{count} : Тип - #{type_tr}"
  end
#отправка поезда
  def send_tr (num)
    @trains.delete(num) 
    puts "Поезд #{num} отправлен"
  end
end