require_relative 'train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'cargo_carriage.rb'
require_relative 'passenger_carriage.rb'

@main_trains = []
@main_stations = []
@main_routes = []

def print_main_menu
  puts "Вам предлагается управлять виртуальной железной дорогой!"
  puts "Выбирете интерфейс:"
  puts "1. Создать станцию."
  puts "2. Создать поезд."
  puts "3. Создать маршрут"
  puts "4. Управлять маршрутом"
  puts "5. Назначить маршрут поезду"
  puts "6. Логистика вагонов"
  puts "7. Задть движение поезда"
  puts "8. Просмотреть состояние станций"
  puts "0. Выход"
  print "Выбирете действие (1-8) : "
end

def create_train
  loop do
    puts "Для выхода из этого меню введите - 0 \nСоздаем новый поезд."
    print "Введите номер создаваемого поезда : "
    num_train = gets.chomp
    break if num_train == "0"
    if @main_trains.find_index { |train| train.num == num_train }
      puts "Поезд уже существует!"
    else
      puts "Какой поезд хотите создать? \n Если грузовой - нажмите 1 \n Если пассажирский - нажмите 2"
      type = gets.chomp
      case type
      when "1"
        @main_trains << CargoTrain.new(num_train)
      when "2"
        @main_trains << PassengerTrain.new(num_train)
      end
      print_trains
    end
  end 
end

def create_station
  loop do
    puts "Для выхода из этого меню введите - 0"
    puts "Создаем новую станцию"
    print "Введите название новой станции : "
    name_station = gets.chomp
    break if name_station == '0'
    if @main_stations.find_index { |station| station.name == name_station }
      puts "Станция уже существует!"
    else
      @main_stations << Station.new(name_station)
    end
    print_stations
  end
end

def print_stations
  puts "Список доступных станций"
  @main_stations.each_with_index {|station, index| puts "#{index+1} -- #{station.name}"}
end

def print_route(route)
  route.stations.each{|station| print "#{station.name} -->"}
  puts ""
end

def print_trains
  puts "Список доступных поездов"
  @main_trains.each_with_index {|train, index| puts "#{index+1} -- #{train.num}"}
end

def print_routes
  puts "Список доступных маршрутов"
  @main_routes.each_with_index do |route, index| 
    print "#{index+1} : " 
    print_route(route)
  end
end

def add_station(route)
  nums_i =[]
  print_stations
  print_route(route)
  puts  "Введите через ',' номера станций, которые хотите добавить в маршрут, учитывая последовательность ввода:"
  nums_st = gets.chomp.split(',')
  nums_st.each {|x| nums_i << x.to_i}
  nums_i.each {|index| route.insert_station(@main_stations[index -1])}
  puts "Результирующий маршрут. (для продолжения нажмите любую клавишу)"
  print_route(route)
  gets
end

def create_route
  loop do
    puts "Создаем новый маршрут."
    print_stations
    print "Введите номер начальной станции или 0 для выхода из меню : "
    index_start = gets.chomp.to_i - 1
    break if index_start == -1
    print "Введите номер конечной станции : "
    index_end = gets.chomp.to_i - 1
    @main_routes << Route.new(@main_stations[index_start], @main_stations[index_end])
    print "Хотите добавить станции в маршрут? (y/n)"
    add_station(@main_routes.last) if 'y' == gets.chomp
  end  
end

def add_route
  print_trains
  print "Введите поезд (1 - #{@main_trains.length}):"
  index_train = gets.chomp.to_i - 1
  print_routes
  print "Введите номер маршрута (1 - #{@main_routes.length}):"
  index_route = gets.chomp.to_i - 1
  @main_trains[index_train].set_route(@main_routes[index_route])
  puts "Маршрут назначен! Поезд находится на станции - #{@main_trains[index_train].current_station.name}\n"
end

def add_carriage
  puts "Для добавления или удаления вагонов необходимо выбрать поезд"
  print_trains
  print "Введите поезд (1 - #{@main_trains.length}):"
  index_train = gets.chomp.to_i - 1
  print "Выбирите действие: добавить или удалить вагоны (1 или 2): "
  choice = gets.chomp
  if '1' == choice
    print "Сколько вагонов необходимо добавить? : "
    count_cars = gets.chomp.to_i
    count_cars.times { |i| @main_trains[index_train].carriage_add(CargoCarriage.new) } if @main_trains[index_train].type == :cargo
    count_cars.times { |i| @main_trains[index_train].carriage_add(PassengerCarriage.new) } if @main_trains[index_train].type == :passenger
  end
  if '2' == choice
    puts "Текущее количество вагонов в составе: #{@main_trains[index_train].carriages.length}"
    print "Сколько вагонов необходимо удалить? : "  
    count_cars = gets.chomp.to_i
    count_cars.times { |i| @main_trains[index_train].carriage_del } 
  end

end

def move_train
  puts "Кокой поезд хотите перемещать?"
  print_trains
  print "Введите поезд (1 - #{@main_trains.length}):"
  index_train = gets.chomp.to_i - 1
  print "Двигаем вперед или назад (1 или 2) : "
  choice = gets.chomp
   @main_trains[index_train].move_forward if choice == '1' 
   @main_trains[index_train].move_forward if choice == '2'
   puts "Поезд #{@main_trains[index_train].num} имеет маршрут:"
   print_route(@main_trains[index_train].route)
   puts "Текущая станция - #{@main_trains[index_train].current_station.name}" 
end

def list_stations
  print_stations
  puts "Для просмотра поездов на станции выбирете нужный номер станции или 0 для выхода:"
  choice = gets.chomp.to_i
  if choice > 0 
    choice-= 1
    if @main_stations[choice].trains.length<1
      puts "На станции нет поездов.\n\n" 
    else
      @main_stations[choice].trains.each {|train| puts "#{train.num}\n"}
    end 
 end
end

def do_main_menu(choice)
  case choice
  when "1"
    create_station
    #system('reset')
  when "2"
    create_train
#    system('reset')
  when "3"
    create_route
#    system('reset')
  when "4"
    puts "Выбирете маршрут для редактирования."
    print_routes  
    index_route = gets.chomp.to_i - 1
    add_station (@main_routes[index_route])
  when "5"
    add_route
  when "6"
    add_carriage
  when "7"
    move_train
  when "8"
    list_stations
  end
end

loop do
  print_main_menu
  choice = gets.chomp 
  break if choice == "0"
  do_main_menu (choice)
end