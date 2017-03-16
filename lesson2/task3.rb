#Заполнить массив числами фибоначчи до 100
my_array=[0,1]
my_array_long=[0,1]

#Считаем для последовательности, в которой участвуют 99 чисел для построения чисел фибоначчи
while my_array_long.size<100 do
  my_array_long << my_array_long[-1]+my_array_long[-2]
end

#Считаем для последовательности, в которой последнее число фибоначчи не превышает значения 100
while my_array.last<100 do
  n = my_array[-1]+my_array[-2] 
  if n < 100
    my_array << n
  else 
    break
  end
end

#проверка количества элементов в массиве
puts my_array_long
puts "\n"
puts my_array
