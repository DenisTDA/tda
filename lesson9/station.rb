# Task 8.
# Class Station

require_relative 'instance_counter.rb'

class Station
  include InstanceCounter
  include Validation

  NAME_FORMAT = /^([a-z|\d]){3,25}$/i

  @@all_stations = []

  def self.all
    @@all_stations
  end

  attr_reader :trains, :name
  validate :name, :format, NAME_FORMAT

  def initialize(name)
    @name = name
    validate!
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

  def each_train
    @trains.each { |train| yield(train) }
  end
end
