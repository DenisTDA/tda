# Module Acessors
# method attr_accessor_with_history
# 
# mathod strong_attr_acessor

module Accessors

  def attr_accessor_with_history(*atrs)
    @values_history = {}
    atrs.each do |name_method|
      @values_history [name_method] ||= [] 
      name_var = "@#{name_method}".to_sym

      define_method(name_method){ instance_variable_get(name_var) } 

      define_method("#{name}=".to_sym) do |value| 
        instance_variable_set(name_var, value) 
        @values_history[name_method] << value
      end

      define_method("#{name_method}_history"){ @values_history[name_method] }
    end
  end

  def strong_attr_accesor(atr, type)
    name_var = "@#{atr}".to_sym
    define_method(atr){ instance_variable_get(name_var) }
    define_method("#{atr}=".to_sym) do |value|
      riase "TypeError!!!" unless value.is_a? type 
      instance_variable_set(name_var, value)
    end
  end
  
end
