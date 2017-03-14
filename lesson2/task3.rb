#Заполнить массив числами фибоначчи до 100
my_array=[0,1]
for index in (2...100) 
	my_array.push (my_array[index-1]+my_array[index-2])
end
#проверка количества элементов в массиве
puts my_array.size
print my_array