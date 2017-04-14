# Task 8
# Class RailWay
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
    when '1'
      system('clear')
      create_station
    when '2'
      system('clear')
      create_train
    when '3'
      system('clear')
      create_route
    when '4'
      system('clear')
      edit_route
    when '5'
      system('clear')
      add_route
    when '6'
      system('clear')
      manipulation_carriages
    when '7'
      system('clear')
      move_train
    when '8'
      system('clear')
      list_stations
    when '9'
      generation
      p 'Data has been generated!'
      pause
    end
  end

  def print_main_menu
    system('clear')
    puts "Вам предлагается управлять виртуальной железной дорогой!\n"
    puts '1. Создать станцию.'
    puts '2. Создать поезд.'
    puts '3. Создать маршрут'
    puts '4. Управлять маршрутом'
    puts '5. Назначить маршрут поезду'
    puts '6. Логистика вагонов'
    puts '7. Задть движение поезда'
    puts '8. Просмотреть состояние станций'
    puts '9. Сгенерировать начальные данные'
    puts "0. Выход\n"
    print 'Выбирете действие (1-9) : '
  end

  private

  def create_station
    loop do
      print_quit
      begin
        print 'Введите название новой станции : '
        name_station = gets.chomp
        break if name_station == '0'
        raise 'Станция уже существует!' if @main_stations.detect do |station|
          station.name == name_station
        end
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
        puts "Какой поезд хотите создать?\nЕсли грузовой - нажмите 1"
        print "Если пассажирский - нажмите 2\n(1 or 2) :"
        type = gets.chomp
        break if type == '0'
        raise 'Not right choice!!!' unless type == '1' || type == '2'
        print 'Введите номер создаваемого поезда : '
        num_train = gets.chomp
        break if num_train == '0'
        raise 'Поезд уже существует!' if @main_trains.detect do |train|
          train.num == num_train
        end
        case type
        when '1'
          @main_trains << CargoTrain.new(num_train)
        when '2'
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
      puts 'Создаем новый маршрут.'
      list_stations?
      index_start = input_index(@main_stations) do
        print 'Введите номер начальной станции : '
      end
      break if index_start == -1
      index_end = input_index(@main_stations) do
        print 'Введите номер конечной станции : '
      end
      break if index_start == -1
      station_start = @main_stations[index_start]
      station_end = @main_stations[index_end]
      @main_routes << Route.new(station_start, station_end)
      print 'Хотите добавить станции в маршрут? (y/n)'
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

  def edit_route
    puts 'Выбирете маршрут для редактирования.'
    begin
      raise 'Error list routs!' unless print_routes
      index_route = input_index(@main_routes) { print '>>' }
      add_station @main_routes[index_route]
    rescue => e
      error_message(e)
      pause
    end
    print_routes
  end

  def move_train
    puts 'Кокой поезд хотите перемещать?'
    list_trains?
    begin
      index_train = input_index(@main_trains) do
        print 'Введите поезд'\
        " (1 - #{@main_trains.length}):"
      end
      print_train_route_station(index_train)
      choice = ''
      loop do
        print 'Двигаем вперед или назад (1 или 2) : '
        choice = gets.chomp
        break if choice == '1' || choice == '2'
      end
      @main_trains[index_train].move_forward if choice == '1'
      @main_trains[index_train].move_back if choice == '2'
      print_train_route_station(index_train)
    rescue => e
      error_message(e)
    end
    pause
  end

  def list_stations
    return if list_stations?
    choice = input_index(@main_stations) do
      print 'Для просмотра поездов'\
      ' на станции выбирете нужный номер станции:'
    end
    station = @main_stations[choice]
    if @main_stations[choice].trains.empty?
      puts "На станции - #{station.name} нет поездов.\n\n"
    else
      puts "На станции - #{station.name} находятся поезда:"
      @main_stations[choice].each_train do |train|
        puts "\n№#{train.num}\t#{'-' * 5}\tТип: #{train.class}#{'-' * 5}"\
          "\tКол-во вагонов: #{train.carriages.length}\n"
        print_carriages(train)
      end
    end
    pause
  rescue => e
    error_message(e)
    pause
  end

  def add_station(route)
    print_stations
    print_route(route)
    print "Введите через ',' номера станций, которые хотите добавить в "\
        'маршрут, учитывая последовательность ввода:'
    arr_numbers = gets.chomp.split(',').map(&:to_i)
    arr_numbers.each do |index|
      index -= 1
      if key_check(index, @main_stations)
        route.insert_station(@main_stations[index])
      else
        mistake
      end
    end
    puts 'Результирующий маршрут:'
    print_route(route)
  rescue => e
    error_message(e)
    pause
  end

  def add_route
    current_station = @main_trains[index_train].current_station
    return if list_trains?
    index_train = input_index(@main_trains) do
      print 'Введите поезд'\
      " (1 - #{@main_trains.length}):"
    end
    return false unless print_routes
    index_route = input_index(@main_routes) do
      print 'Введите номер маршрута'\
      " (1 - #{@main_routes.length}):"
    end
    @main_trains[index_train].route_set(@main_routes[index_route])
    puts 'Маршрут назначен!'
    print_route(@main_routes[index_route])
    puts "Поезд находится на станции - #{current_station.name}\n"
  rescue => e
    error_message(e)
  end

  def add_by_type(type, index_train, count_cars)
    train = @main_trains[index_train]
    count_cars.times do |index|
      puts "Введите вместимость вагона #{type} №#{index + 1}"
      train.carriage_add(type.new(gets.chomp))
    end
  end

  def manipulation_carriages
    puts 'Для добавления или удаления вагонов необходимо выбрать поезд'
    return if list_trains?
    index_train = input_index(@main_trains) do
      print 'Введите поезд'\
      " (1 - #{@main_trains.length}):"
    end
    print 'Выбирите действие: добавить, '\
      'удалить или заполнить вагоны (1, 2 или 3): '
    choice = gets.chomp
    if choice == '1'
      add_carriage(index_train)
    elsif choice == '2'
      delete_carriage(index_train)
    elsif choice == '3'
      load_carriage(@main_trains[index_train])
    else
      mistake
      pause
    end
  rescue => e
    error_message(e)
  end

  def add_carriage(index_train)
    type = { car: CargoCarriage, pass: PassengerCarriage }
    train = @main_trains[index_train]
    print 'Сколько вагонов необходимо добавить? : '
    count_cars = gets.chomp.to_i
    train = @main_trains[index_train]
    add_by_type(type[:car], index_train, count_cars) if train.class == CargoTrain
    add_by_type(type[:pass], index_train, count_cars) if train.class == PassengerTrain
    puts "Текущее количество вагонов в составе: #{train.carriages.length}"
    pause
  end

  def delete_carriage(index_train)
    train = @main_trains[index_train]
    puts "Текущее количество вагонов в составе #{train.num}: "\
      "#{train.carriages.length}"
    print 'Сколько вагонов необходимо удалить? : '
    count_cars = gets.chomp.to_i
    count_cars.times { @main_trains[index_train].carriage_del }
    puts 'Текущее количество вагонов в составе: '\
        "#{@main_trains[index_train].carriages.length}"
    pause
  end

  def load_carriage(train)
    index_carriage = 0
    puts "Текущее количество вагонов в составе #{train.num}:"\
        " #{train.carriages.length}"
    print_carriages(train)
    index_carriage = input_index(train.carriages) do
      print 'Какой вагон будем заполнять: '
    end
    print_carriage(index_carriage, train)
    print 'Сколько будем заполнять? - '
    cargo = gets.chomp
    if train.class == CargoTrain
      cargo = cargo.to_f
    elsif train.class == PassengerTrain
      cargo = cargo.to_i
    end
    train.carriages[index_carriage].loading(cargo)
    print_carriage(index_carriage, train)
    pause
  rescue => e
    error_message(e)
    pause
  end

  def input_index(array)
    index_arr = 0
    loop do
      yield
      index_arr = gets.chomp.to_i - 1
      break if index_arr == -1 || key_check(index_arr, array)
    end
    index_arr
  end

  def print_carriage(index_carriage, train)
    carriage = train.carriages[index_carriage]
    puts "\nВагон #{index_carriage + 1}: всего - "\
    "#{carriage.capacity}; свободно - #{carriage.capacity_free};"\
    ' занято - #carriage.capacity_loaded}'
  end

  def print_train_route_station(index_train)
    train = @main_trains[index_train]
    puts "Поезд #{train.num} имеет маршрут:"
    print_route(@main_trains[index_train].route)
    puts "Текущая станция - #{train.current_station.name}"
  end

  def print_stations
    if !@main_stations.empty?
      puts 'Список доступных станций'
      @main_stations.each.with_index(1) do |station, index|
        puts "#{index} -- #{station.name}"
      end
    else
      list_empty
    end
  end

  def print_trains
    if !@main_trains.empty?
      puts 'Список доступных поездов'
      @main_trains.each.with_index(1) do |train, index|
        puts "#{index}\t--"\
      "\t#{train.num}\t--\t#{train.class}#--\t#{train.carriages.length}"
      end
      puts
    else
      list_empty
    end
  end

  def print_routes
    if !@main_routes.empty?
      puts 'Список доступных маршрутов'
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
    puts '_' * 70
    index = 1
    train.each_carriage do |carriage|
      puts "#{index}\t| \t\t #{carriage.capacity_loaded}\t| \t\t"\
        " #{carriage.capacity_free}\t\t|"
      index += 1
    end
  end

  def list_trains?
    return false unless print_trains
  end

  def list_stations?
    unless print_stations
      pause
      true
    end
  end

  def list_empty
    puts 'Список пуст'
  end

  def pause
    puts "\nДля продолжения нажмитие любую клавишу."
    gets
  end

  def key_check(key, max_volume)
    raise 'Error of input!!!' unless (0...max_volume.size).cover?(key)
    true
  end

  def mistake
    puts "Вы сделали не правильный выбор! Повторите.\n"
  end

  def error_message(e)
    puts "\n\tError!!! ==> #{e.message}\n"
  end
end
