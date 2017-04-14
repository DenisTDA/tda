# Task8
# Bigin of the Begining
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
