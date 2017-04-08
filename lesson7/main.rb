# 7
# Если у вас есть интерфейс, то добавить возможности:
# При создании вагона указывать кол-во мест или общий объем, в зависимости от типа вагона
# Выводить список вагонов у поезда (в указанном выше формате)
# Выводить список поездов на станции (в указанном выше формате)
# Занимать место или объем в вагоне

require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'
require_relative 'train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'cargo_carriage.rb'
require_relative 'passenger_carriage.rb'
require_relative 'railway.rb'



railway = RailWay.new

loop do
  system('clear')
  railway.print_main_menu
  choice = gets.chomp 
  break if choice == '0'
  railway.do_main_menu(choice)
end