# Task 8
# Train class

require_relative 'instance_counter.rb'

class Train
  include Manufacturer
  include InstanceCounter

  @@all_trains = {}
  attr_reader :carriages, :route, :speed, :num
  NUM_FORMAT = /^(\d|[a-z]){3}-?(\d|[a-z]){2}$/i
  NUM_LENGTH = 6

  def initialize(num)
    @num = num
    validate_num!
    @speed = 0
    @carriages = []
    @@all_trains[num] = self
    register_instance
  end

  def self.find(number_train)
    @@all_trains[number_train]
  end

  def up_speed(increment = 1)
    @speed += increment
  end

  def down_speed(decr = 1)
    if @speed >= decr
      @speed -= decr
    else
      stop!
    end
  end

  def carriage_add(car)
    @carriages << car if stoped? && type_validation?(car)
  end

  def carriage_del
    @carriages.pop if stoped? && not_empty?
  end

  def route_set(route)
    self.route = route
    stop!
    self.station_index = 0
    @route.stations[0].take_train(self)
  end

  def current_station
    @route.stations[station_index] if route
  end

  def move_forward
    if not_last?
      current_station.send_train(self)
      @station_index += 1
      current_station.take_train(self)
    else
      @station_index
    end
  end

  def move_back
    if not_first?
      current_station.send_train(self)
      @station_index -= 1
      current_station.take_train(self)
    else
      @station_index
    end
  end

  def previus_station
    @route.stations[previus!] if not_first?
  end

  def next_station
    @route.stations[next!] if not_last?
  end

  def stop!
    self.speed = 0
  end

  def valid?
    validate_num!
  rescue => e
    puts "Error!!! ==> #{e}"
    false
  end

  def each_carriage
    @carriages.each { |carriage| yield(carriage) }
  end

  # PROTECTED

  protected

  def type_validation?(carriage); end

  # PRIVATE

  private

  attr_accessor :station_index
  attr_writer :route, :speed

  def validate_num!
    raise 'Number has invalid format! Must be: XXX-XX or XXXXX' if @num !~ NUM_FORMAT
    true
  end

  def not_empty?
    !@carriages.empty?
  end

  def stoped?
    @speed.zero?
  end

  def not_last?
    @route.stations.length > @station_index + 1
  end

  def not_first?
    station_index > 0
  end

  def next!
    @station_index + 1
  end

  def pevius!
    @station_index - 1
  end
end
