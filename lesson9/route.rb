# Task 9
# Class Route
require_relative "validation.rb"


class Route
  include Validation

  attr_reader :stations, :end_station, :start_station

  validate :start_station, :presence
  validate :start_station, :presence
  validate :start_station, :type, Station
  validate :end_station, :type, Station


  def initialize(start_station, end_station)
    @end_station = end_station
    @start_station = start_station
    @stations = [@start_station, @end_station]
    validate!
  end

  def insert_station(station)
    raise if station == @stations.last || station == @stations[-2]
    @stations.insert(-2, station)
  end

  def del_station(station)
    raise if @stations.size < 3 || !@stations.include?(station)
    @stations.delete(station)
  end
end
