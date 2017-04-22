# Module Validation

module Validation
  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(attr_name, type_validation, ext_attr = nil)
      @parameters ||= []
      @parameters << { attr_name => { type: type_validation, ext: ext_attr } }
    end
  end

  module InstanceMethods
    def validate!
      self.class.instance_variable_get(:@parameters).each do |parameter_line|
        parameter_line.each do |attr_name, data_valid|
          variable = instance_variable_get("@#{attr_name}")
          send(data_valid[:type], variable, data_valid[:ext])
        end
      end
    end

    def valid?
      validate!
    rescue => e
      puts "Error!!! ==> #{e.message}"
      false
    end

    def presence(attr, _ext_attr)
      raise "PresenceError #{attr}" unless !!attr || attr == 0 || attr == ''
    end

    def format(attr, format_attr)
      raise "FormatError #{attr}..." if attr.to_s !~ format_attr
    end

    def type(attr, type_attr)
      raise "TypeError #{attr}..." unless attr.is_a?(type_attr)
    end
  end
end
