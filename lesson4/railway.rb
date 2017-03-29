class RailWay

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
      if !print_routes  
        pause
        return false
      end
      index_route = gets.chomp.to_i - 1 until key_check(index_route, @main_routes)
      add_station (@main_routes[index_route])
      system('clear')      
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
    puts "0. Выход\n"
    print "Выбирете действие (1-8) : "
  end

  private
  def create_station
    loop do
      print_quit
      name_station = ''
      begin
        print "Введите название новой станции : "
        name_station = gets.chomp
      end until name_station.length > 1 ||  name_station =='0'
      break if name_station == '0'        
      if @main_stations.detect { |station| station.name == name_station }
        puts "Станция уже существует!"
      else
        @main_stations << Station.new(name_station)
      end
      print_stations
    end
  end

  def create_train
    loop do
      print_quit
      print "Введите номер создаваемого поезда : "
      num_train = gets.chomp
      break if num_train == "0"
      if @main_trains.detect { |train| train.num == num_train }
        puts "Поезд уже существует!"
      elsif num_train == ''
        mistake
      else
        puts "Какой поезд хотите создать? \n Если грузовой - нажмите 1 \n Если пассажирский - нажмите 2"
        type = gets.chomp
        case type
        when "1"
          @main_trains << CargoTrain.new(num_train)
        when "2"
          @main_trains << PassengerTrain.new(num_train)
        else
          mistake
        end
        print_trains
      end
    end 
  end

  def create_route
    loop do
      print_quit
      puts "Создаем новый маршрут."
      if !print_stations
        pause
        return false 
      end
      begin
        print "Введите номер начальной станции : "
        index_start = gets.chomp.to_i - 1  
      end until key_check(index_start,@main_stations) || index_start == -1 
      
      break if index_start == -1
      begin
        print "Введите номер конечной станции : "
        index_end = gets.chomp.to_i - 1
      end until key_check(index_end,@main_stations) || index_end == -1 
      
      @main_routes << Route.new(@main_stations[index_start], @main_stations[index_end])
      print "Хотите добавить станции в маршрут? (y/n)"
      if 'y' == gets.chomp 
        add_station(@main_routes.last) 
      else
        break
      end
    end  
  end

  def move_train
    puts "Кокой поезд хотите перемещать?"
    if !print_trains
      pause
      return false 
    end    
    begin
      print "Введите поезд (1 - #{@main_trains.length}):"
      index_train = gets.chomp.to_i - 1  
    end until key_check(index_train,@main_trains)
    begin
      print "Двигаем вперед или назад (1 или 2) : "
      choice = gets.chomp 
    end until choice != '1' || choice != '2'
    @main_trains[index_train].move_forward if choice == '1' 
    @main_trains[index_train].move_back if choice == '2'
    puts "Поезд #{@main_trains[index_train].num} имеет маршрут:"
    print_route(@main_trains[index_train].route)
    puts "Текущая станция - #{@main_trains[index_train].current_station.name}" 
    pause
  end

  def list_stations
    if !print_stations
      pause
      return false 
    end    
    begin
      print "Для просмотра поездов на станции выбирете нужный номер станции:"
      choice = gets.chomp.to_i - 1 
    end until key_check(choice, @main_stations)
    if @main_stations[choice].trains.length<1
      puts "На станции - #{@main_stations[choice].name} нет поездов.\n\n" 
    else
      @main_stations[choice].trains.each {|train| puts "#{train.num}\n"}
    end 
    pause
  end

  def add_station(route)
    arr_numbers = []
    print_stations 
    print_route(route)
    print  "Введите через ',' номера станций, которые хотите добавить в маршрут, учитывая последовательность ввода:"
    arr_numbers = gets.chomp.split(',')
    arr_numbers.map! {|x| x.to_i}
    arr_numbers.each {|index| 
      index-=1
      if key_check(index, @main_stations)
        route.insert_station(@main_stations[index]) 
      else
        mistake
        return false
      end
    }
    puts "Результирующий маршрут:"
    print_route(route)
    pause
  end

  def add_route
    if !print_trains
      pause
      return false
    end
    begin
      print "Введите поезд (1 - #{@main_trains.length}):"
      index_train = gets.chomp.to_i - 1
    end until key_check(index_train, @main_trains)
    return false if !print_routes 
    begin
      print "Введите номер маршрута (1 - #{@main_routes.length}):"  
      index_route = gets.chomp.to_i - 1
    end until key_check(index_route, @main_routes)
    @main_trains[index_train].set_route(@main_routes[index_route])
    puts "Маршрут назначен!" 
    puts "#{@main_routes[index_route]}"
    puts "Поезд находится на станции - #{@main_trains[index_train].current_station.name}\n"
  end

  def add_carriage
    puts "Для добавления или удаления вагонов необходимо выбрать поезд"
    if !print_trains
      pause
      return false
    end
    begin
      print "Введите поезд (1 - #{@main_trains.length}):"
      index_train = gets.chomp.to_i - 1  
    end until key_check(index_train, @main_trains)
    print "Выбирите действие: добавить или удалить вагоны (1 или 2): "
    choice = gets.chomp
    if choice == '1'
      print "Сколько вагонов необходимо добавить? : "
      count_cars = gets.chomp.to_i
      count_cars.times { @main_trains[index_train].carriage_add(CargoCarriage.new) } if @main_trains[index_train].class == CargoTrain
      count_cars.times { @main_trains[index_train].carriage_add(PassengerCarriage.new) } if @main_trains[index_train].class == PassengerTrain
    elsif choice == '2'
      puts "Текущее количество вагонов в составе: #{@main_trains[index_train].carriages.length}"
      print "Сколько вагонов необходимо удалить? : "  
      count_cars = gets.chomp.to_i
      count_cars.times { |i| @main_trains[index_train].carriage_del } 
    else
      puts "Вы сделали не правильный выбор! Повторите."
      pause
    end
  end

  def print_stations
    if @main_stations.size > 0
      puts "Список доступных станций"
      @main_stations.each.with_index(1) {|station, index| puts "#{index} -- #{station.name}"}
    else
      list_empty
      return false
    end
  end

  def print_route(route)                                                                                                                                                                                                                                
    route.stations.each {|station| 
      print station.name
      print " --> " if station != route.stations.last
    } 
    puts''
  end

  def print_trains
    if @main_trains.size > 0
      puts "Список доступных поездов"
      @main_trains.each.with_index(1) {|train, index| puts "#{index} -- #{train.num}"}
    else
      list_empty
      return false
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
      return false
    end
  end  

  def print_quit
    puts "Для выхода из этого меню введите - 0 \n"
  end

  def list_empty
    puts "Список пуст"
  end

  def pause
    puts "\nДля продолжения нажмитие любую клавишу."
    gets
  end

  def key_check (key, max_volume)
    if (0...max_volume.size).include?(key) 
      return true 
    else
      puts "Наверно Вы ошиблись с набором... попробуйте еще раз!"
      return false
    end 
  end

  def mistake
    puts "Вы сделали не правильный выбор! Повторите.\n"
    return false
  end
end
