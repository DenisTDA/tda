=begin
Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя). Найти порядковый номер даты, 
начиная отсчет с начала года. Учесть, что год может быть високосным. 
(Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?)
Алгоритм опредления високосного года: www.adm.yar.ru
=end
year=nil
month=nil
day=nil
count_days=0
in_month=[31,28,31,30,31,30,31,31,30,31,30,31]

loop do
  print "Введите год: "
  year = gets.chomp.to_i 
  if year>0
    break
  else
    puts"Неверно введен год! Значение должно лежать от 1 до ближайшего будущего"
  end
end
#проверка: высокосный ли год
  leap_year = (year%4==0) && (year%400==0 || year%100!=0)


#ввод и проверка ввода месяца
loop do
  print "Введите месяц: "
  month = gets.chomp.to_i 
  if month.between?(1,12) 
    in_month[1]=29 if leap_year # Если високосный, то меняем количество дней в феврале
    break
  else
    puts"Неверно введен месяц! Значение должно лежать от 1 до 12."
  end
end
#ввод и проверка ввода дня даты
loop do
  print "Введите число: "
  day = gets.chomp.to_i 
  if day.between?(1,in_month[month-1])
    break
  else
    puts"Неверно введен день! Введите заново."
  end
end

#считаем дни месяцев, которые уже прошли с начало года
in_month.each.with_index { |days, index| count_days += days if index <month-1 } 

count_days+=day #Добовляем дни текущего месяца

puts "С начала #{year} года  #{day} число  #{month} месяца имеет порядковый номер - #{count_days}"