module Generation

 def generation
    11.times{|index| @main_stations << Station.new("Station#{index}")}
    2.times{|index| @main_trains << CargoTrain.new("Carg#{index}")}
    3.times{|index| @main_trains << PassengerTrain.new("Pass#{index}")}
    5.times{|index| @main_routes << Route.new(@main_stations[index], @main_stations[-(index+1)])}
    5.times{|index| @main_trains[index].set_route(@main_routes[index])}
  end
end
