# Module Acessors
# method attr_accessor_with_history
#
# mathod strong_attr_acessor

module Accessors
  def attr_accessor_with_history(*attrs)
    attrs.each do |attr_name|
      name_var = "@#{attr_name}".to_sym
      values = []
      
      define_method(attr_name) { instance_variable_get(name_var) }
      define_method("#{attr_name}=".to_sym) do |value|
        if instance_variable_defined?(name_var)
          values << instance_variable_get(name_var)
        end
        instance_variable_set(name_var, value)        
      end
      define_method("#{attr_name}_history") { values }
    end
  end

  def strong_attr_accesor(atr, type)
    name_var = "@#{atr}".to_sym
    define_method(atr) { instance_variable_get(name_var) }
    define_method("#{atr}=".to_sym) do |value|
      raise 'TypeError!!!' unless value.is_a? type
      instance_variable_set(name_var, value)
    end
  end
end
