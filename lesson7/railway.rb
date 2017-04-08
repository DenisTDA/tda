#7. 
# Если у вас есть интерфейс, то добавить возможности:
# При создании вагона указывать кол-во мест или общий объем, в зависимости от типа вагона
# Выводить список вагонов у поезда (в указанном выше формате)
# Выводить список поездов на станции (в указанном выше формате)
# Занимать место или объем в вагоне
require_relative 'generation.rb'


class RailWay
include Generation

  def initialize
    @main_trains = []
    @main_stations = []
    @main_routes = []
  end

 
  def do_main_menu(choice)
    case choice
    when "1"
      create_station
      system('clear')
    when "2"
      create_train
      system('clear')
    when "3"
      create_route
      system('clear')
    when "4"
      puts "Выбирете маршрут для редактирования."
      begin
        raise "Error list routs!" unless print_routes  
        begin 
          print "> "
          index_route = gets.chomp.to_i - 1 
        end until key_check(index_route, @main_routes)
        add_station (@main_routes[index_route])
      rescue => e
        error_message(e)
        pause
      end
      print_routes
    when "5"
      add_route
      system('clear')      
    when "6"
      add_carriage
      system('clear')
    when "7"
      move_train
      system('clear')
    when "8"
      list_stations
      system('clear')
    when "9"
      generation
      p "Data has been generated!"
      pause
    end
  end

def print_main_menu
    puts "Вам предлагается управлять виртуальной железной дорогой!\n"
    puts "1. Создать станцию."
    puts "2. Создать поезд."
    puts "3. Создать маршрут"
    puts "4. Управлять маршрутом"
    puts "5. Назначить маршрут поезду"
    puts "6. Логистика вагонов"
    puts "7. Задть движение поезда"
    puts "8. Просмотреть состояние станций"
    puts "9. Сгенерировать начальные данные"
    puts "0. Выход\n"
    print "Выбирете действие (1-9) : "
  end

  private
  def create_station
    loop do
      print_quit
      begin
        print "Введите название новой станции : "
        name_station = gets.chomp
        break if name_station == '0'             
        raise "Станция уже существует!" if @main_stations.detect { |station| station.name == name_station }
        @main_stations << Station.new(name_station)
      rescue => e
        error_message(e)
      end
      print_stations
    end
  end

  def create_train
    system('clear')
    loop do
      print_quit
      begin 
        print "Какой поезд хотите создать?\nЕсли грузовой - нажмите 1\nЕсли пассажирский - нажмите 2\n(1 or 2) :"
        type = gets.chomp
        break if type == "0"
        raise "Not right choice!!!" unless type.eql?("1") || type.eql?("2") 
        print "Введите номер создаваемого поезда : "
        num_train = gets.chomp
        break if num_train == "0"
        raise "Поезд уже существует!" if @main_trains.detect { |train| train.num == num_train }
        case type
        when "1"
          @main_trains << CargoTrain.new(num_train)
        when "2"
          @main_trains << PassengerTrain.new(num_train)
        end
      rescue => e
        error_message(e)
      end
      print_trains
    end 
  end

  def create_route
    loop do
      print_quit
      puts "Создаем новый маршрут."
      list_stations?
      begin
        print "Введите номер начальной станции : "
        index_start = gets.chomp.to_i - 1  
      end until index_start == -1 || key_check(index_start,@main_stations)
      break if index_start == -1
     
      begin
        print "Введите номер конечной станции : "
        index_end = gets.chomp.to_i - 1
      end until index_end == -1 || key_check(index_end,@main_stations)
      break if index_end == -1
      
      @main_routes << Route.new(@main_stations[index_start], @main_stations[index_end])
      print "Хотите добавить станции в маршрут? (y/n)"
      if 'y' == gets.chomp 
        add_station(@main_routes.last) 
      else
        print_route(@main_routes.last)
        pause
        break
      end
    end  
  rescue => e
      error_message(e)
      retry
  end

  def move_train
    puts "Кокой поезд хотите перемещать?"
    list_trains?
    begin
      begin
        print "Введите поезд (1 - #{@main_trains.length}):"
        index_train = gets.chomp.to_i - 1  
      end until key_check(index_train,@main_trains)
      print_train_route_station(index_train)      
      begin
        print "Двигаем вперед или назад (1 или 2) : "
        choice = gets.chomp 
      end until choice != '1' || choice != '2'
      @main_trains[index_train].move_forward if choice == '1' 
      @main_trains[index_train].move_back if choice == '2'
      print_train_route_station(index_train)
    rescue => e
      error_message(e)
    end
    pause
  end

  def list_stations
    list_stations?
    begin
      print "Для просмотра поездов на станции выбирете нужный номер станции:"
      choice = gets.chomp.to_i - 1 
    end until key_check(choice, @main_stations)
    if @main_stations[choice].trains.length<1
      puts "На станции - #{@main_stations[choice].name} нет поездов.\n\n" 
    else
      puts "На станции - #{@main_stations[choice].name} находятся поезда:" 
      # @main_stations[choice].trains.each{|train| puts "#{train.num}\t#{'-'*5}\t#{train.class}#{'-'*5}\t#{train.carriages.length}"}
      @main_stations[choice].trains.each do |train| 
        puts "#{train.num}\t#{'-'*5}\t#{train.class}#{'-'*5}\t#{train.carriages.length}"
        print_carriages(train)
      end
      pause
    end 

  rescue => e
    error_message(e)
    pause
  end

  def add_station(route)
    print_stations 
    print_route(route)
    print  "Введите через ',' номера станций, которые хотите добавить в маршрут, учитывая последовательность ввода:"
    arr_numbers = gets.chomp.split(',').map(&:to_i)
    arr_numbers.each do |index| 
      index -= 1
      if key_check(index, @main_stations)
        route.insert_station(@main_stations[index]) 
      else
        mistake
      end
    end
    puts "Результирующий маршрут:"
    print_route(route)
  rescue => e
    error_message(e)
    pause
  end

  def add_route
    list_trains?
    begin
      print "Введите поезд (1 - #{@main_trains.length}):"
      index_train = gets.chomp.to_i - 1
    end until key_check(index_train, @main_trains)
    return false unless print_routes 
    begin
      print "Введите номер маршрута (1 - #{@main_routes.length}):"  
      index_route = gets.chomp.to_i - 1
    end until key_check(index_route, @main_routes)
    @main_trains[index_train].set_route(@main_routes[index_route])
    puts "Маршрут назначен!" 
    print_route(@main_routes[index_route])
    puts "Поезд находится на станции - #{@main_trains[index_train].current_station.name}\n"
  rescue => e
    error_message(e)
  end

  def add_carriage
    puts "Для добавления или удаления вагонов необходимо выбрать поезд"
    list_trains?
    begin
      print "Введите поезд (1 - #{@main_trains.length}):"
      index_train = gets.chomp.to_i - 1  
    end until key_check(index_train, @main_trains)
    print "Выбирите действие: добавить, удалить или заполнить вагоны (1, 2 или 3): "
    choice = gets.chomp
    if choice == '1'
      print "Сколько вагонов необходимо добавить? : "
      count_cars = gets.chomp.to_i
      if @main_trains[index_train].class == CargoTrain
        count_cars.times do |index| 
          puts "Введите допустимый объем для вагона №#{index+1}" 
          @main_trains[index_train].carriage_add(CargoCarriage.new(gets.chomp))
        end
      end
      if @main_trains[index_train].class == PassengerTrain
        count_cars.times do |index|
          puts "Введите количество допустимых мест для вагона №#{index+1}" 
          @main_trains[index_train].carriage_add(PassengerCarriage.new(gets.chomp))  
        end
      end
      puts "Текущее количество вагонов в составе: #{@main_trains[index_train].carriages.length}"      
      pause
    elsif choice == '2'
      puts "Текущее количество вагонов в составе #{@main_trains[index_train].num}: #{@main_trains[index_train].carriages.length}"
      print "Сколько вагонов необходимо удалить? : "  
      count_cars = gets.chomp.to_i
      count_cars.times { |i| @main_trains[index_train].carriage_del } 
      puts "Текущее количество вагонов в составе: #{@main_trains[index_train].carriages.length}"      
      pause
    elsif choice == '3'
      load_carriage(@main_trains[index_train])
    else
      puts "Вы сделали не правильный выбор! Повторите."
      pause
    end
  rescue => e
    error_message(e)
  end

  def load_carriage(train)
    index_carriage = 0
    puts "Текущее количество вагонов в составе #{train.num}: #{train.carriages.length}"
    print_carriages(train)
    begin
      print "Какой вагон будем заполнять: "  
      index_carriage = (gets.chomp.to_i) -1 
      pause
    end until key_check(index_carriage,train.carriages)
    p "after"

    print_carriage(index_carriage, train)
    print "Сколько будем заполнять? - "
    cargo = gets.chomp
    train.carriages[index_carriage].loading(cargo)
    print_carriage(index_carriage, train)   
    pause
 
  rescue => e
    error_message(e)
    pause
  end

  def print_carriage (index_carriage, train)
    puts "Вагон #{index_carriage+1}: всего -#{train.carriages[index_carriage].capacity}; свободно - #{train.carriages[index_carriage].capacity_free} "
  end

  def print_train_route_station (index_train)
      puts "Поезд #{@main_trains[index_train].num} имеет маршрут:"
      print_route(@main_trains[index_train].route)
      puts "Текущая станция - #{@main_trains[index_train].current_station.name}" 
  end

  def print_stations
    if @main_stations.size > 0
      puts "Список доступных станций"
      @main_stations.each.with_index(1) {|station, index| puts "#{index} -- #{station.name}"}
    else
      list_empty
    end
  end

  def print_trains
    if @main_trains.size > 0
      puts "Список доступных поездов"
      @main_trains.each.with_index(1) {|train, index| puts "#{index}\t--\t#{train.num}\t--\t#{train.class}#--\t#{train.carriages.length}"}
      puts 
    else
      list_empty
    end
  end

  def print_routes
    if @main_routes.size > 0
      puts "Список доступных маршрутов"
      @main_routes.each.with_index(1) do |route, index| 
        print "#{index} : " 
        print_route(route)
      end
    else
      list_empty
    end
  end  

  def print_route(route) 
    puts route.stations.map(&:name).join(' --> ')                                                                                                                                                                                                                               
  end

  def print_quit
    puts "Для выхода из этого меню введите - 0 \n"
  end

  def print_carriages(train)
    puts "Список вагонов для поезда №#{train.num}"
    puts "№№ \t занятые единицы\t свободные единицы"
    puts "#{'_'*70}"
    index = 1
    train.carriages.each do |carriage| 
      puts "#{index}\t| \t\t #{carriage.capacity_loaded}\t| \t\t #{carriage.capacity_free}\t|"
      index += 1
    end
  end

  def list_trains?
    return false unless print_trains
  end

  def list_stations?
    unless print_stations
      pause
      return true
    end
  end

  def list_empty
    puts "Список пуст"
  end

  def pause
    puts "\nДля продолжения нажмитие любую клавишу."
    gets
  end

  def key_check(key, max_volume)
    raise "Error of input!!!" if !(0...max_volume.size).include?(key) 
    true
  end

  def mistake
    puts "Вы сделали не правильный выбор! Повторите.\n"
  end

  def error_message(e)
    puts "\n\tError!!! ==> #{e.message}\n"
  end
end
