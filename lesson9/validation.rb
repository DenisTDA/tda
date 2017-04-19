# Module Validation

module Validation
  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(attr_name, type_validation, ext_attr = nil)
      @parameters ||= []
      @parameters << { attr_name: {type: :type_validation, ext: :ext_attr} }
    end
  end

  module InstanceMethods
    def validate!
      test =  self.class.instance_variable_get(:@parameters)
      self.class.instance_variable_get(:@parameters).each do |parameter_line|
        parameter_line.each do |attr_name, data_valid|
          variable  = instance_variable_get("@#{attr_name}")
          self.send(data_valid[type], varariable, data_valid[ext])
        end
      end
    end

  def valid?
    validate!
  rescue => e
    puts "Error!!! ==> #{e.message}"
    false
  end

    def presence(attr_name)
      raise "PresenceError #{attr_name}..." if !atr_name || attr_name.empty?
    end

    def format(number, format_number)
      raise "FormatError #{number}..." if number.to_s !~ format_number      
    end

    def type(object, object_type)
      raise "TypeError #{object}..." unless object.is_a?(object_type)
    end
  end
end