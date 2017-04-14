# Task 8
# Automatic generation data
module Generation
  def generation
    11.times { |index| @main_stations << Station.new("Station#{index}") }
    2.times { |index| @main_trains << CargoTrain.new("Carg#{index}") }
    3.times { |index| @main_trains << PassengerTrain.new("Pass#{index}") }
    5.times { |index| @main_routes << Route.new(@main_stations[index], 
      @main_stations[-(index + 1)]) 
    }
    5.times { |index| @main_trains[index].route_set(@main_routes[index]) }
    2.times do |index| 
      10.times { @main_trains[index].carriage_add(CargoCarriage.new(rand(100..1000))) }
    end
    for index in 2..4 do 
      10.times { @main_trains[index].carriage_add(PassengerCarriage.new(rand(10..60))) }
    end
  end
 end
