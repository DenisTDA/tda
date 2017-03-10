#first task
puts "Введите имя:"
name = gets.chomp
puts "Введите рост (в сантиметрах):"
height = gets.chomp

i_weight = height.to_i - 110

if i_weight < 0
  puts "#{name.capitalize}, ваш вес уже оптимальный!"
else
  puts "#{name.capitalize}, ваш идеальный вес - #{i_weight} кг."
end
