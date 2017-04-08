=begin
  
Класс Route (Маршрут):
Имеет начальную и конечную станцию, а также список промежуточных станций. 
    Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной
  
=end

class Route 
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations=[start_station, end_station]
    validate!
  end

  def insert_station(station)
    raise if station == @stations.last || station == @stations[-2]
    @stations.insert(-2, station)
  end

  def del_station(station)
    raise if @stations.size <3 || !@stations.include?(station)
    @stations.delete(station)
  end

  def valid?
    validate!
  rescue => e
    puts e.massege
    false
  end

  private
  def validate!
    raise "Stations must be defferent!" if @stations.first == @stations.last
    raise "Error! Type is not valid!" unless @stations.all? { |station| station.is_a?(Station) }
    true
  end
end