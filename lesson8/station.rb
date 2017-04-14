# Task 8.
# Class Station

require_relative 'instance_counter.rb'

class Station
  include InstanceCounter

  NAME_FORMAT = /^([a-z|\d]){3,25}$/i
  LENGTH_NAME = 3

  attr_reader :trains, :name
  @@all_stations = []

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    validate_name!
    @trains = []
    @@all_stations << self
    register_instance
  end

  def take_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.count { |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end

  def valid?(_name)
    validate_name!
  rescue => e
    puts "Error!!! ==> #{e.message}"
    false
  end

  def each_train
    @trains.each { |train| yield(train) }
  end

  private

  def validate_name!
    raise 'FormatError!!! FORMAT ==>[a-z0-9]==> X{3,15}' if @name !~ NAME_FORMAT
    true
  end
end
