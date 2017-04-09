# Класс - пассажирский вагон 
# 5.
# Подключить модуль к классам Вагон и Поезд
# require_relative 'manufacturer.rb'
# 7.
# Для пассажирских вагонов:
# Добавить атрибут общего кол-ва мест (задается при создании вагона)
# Добавить метод, который "занимает места" в вагоне (по одному за раз)
# Добавить метод, который возвращает кол-во занятых мест в вагоне
# Добавить метод, возвращающий кол-во свободных мест в вагоне.

class PassengerCarriage
  include Manufacturer
    
   attr_reader :capacity, :capacity_free, :capacity_loaded

  def initialize(capacity)
    @capacity = capacity.to_i
    validate!
    @capacity_free = @capacity
    @capacity_loaded = 0
  end

  def loading(load_capacity)
    if @capacity_free >= load_capacity.to_i 
      @capacity_free -= load_capacity.to_i
      @capacity_loaded += load_capacity.to_i
    else 
      puts "Overload! Operation abort!"
    end
  end
  
  private
  def validate!
    raise "Data Error!" if @capacity < 0    
  end
end