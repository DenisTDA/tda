# Класс - грузовой вагон
# 5.
# Подключить модуль к классам Вагон и Поезд
# require_relative 'manufacturer.rb'
# 7.
# Для грузовых вагонов:
# Добавить атрибут общего объема (задается при создании вагона)
# Добавить метод, которые "занимает объем" в вагоне (объем указывается в качестве параметра метода)
# Добавить метод, который возвращает занятый объем
# Добавить метод, который возвращает оставшийся (доступный) объем


class CargoCarriage
  include Manufacturer
  
  attr_reader :capacity, :capacity_free, :capacity_loaded

  def initialize(capacity)
    @capacity = capacity.to_f
    validate!
    @capacity_free = @capacity
    @capacity_loaded = 0
  end

  def loading(load_capacity)
    if @capacity_free >= load_capacity 
      @capacity_free -= load_capacity
      @capacity_loaded += load_capacity
    else 
      puts "Overload! Operation abort!"
    end
  end
  
  private
  def validate!
    raise "Data Error!" if @capacity < 0    
  end

end