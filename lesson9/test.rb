require_relative 'accessors.rb'

class Test
  extend Accessors

  attr_accessor_with_history :a, :b, :c
  strong_attr_accesor :m , Array
end

test1 = Test.new
p test1.methods
test1.instance_variables

test1.a = 3
p test1.a
test1.a = 6
p test1.a
test1.a = 'test-a'
p test1.a
p test1.a_history

test1.b = [2,3,65]
p test1.b
test1.b = 6.456
p test1.b
test1.b = 'test-b'
p test1.b
p test1.b_history

test1.m = [3,5,8]
p test1.m

test1.m = 'mistake'
p test1.m
gets
