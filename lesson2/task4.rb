#Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
#alphabat1 - для алфавита русского языка, alphabat2 - для английского языка
alphabat1=Hash.new("пусто")
alphabat2=Hash.new("miss")
index=1
for letter in ('a'..'z') do
	alphabat2.store(letter, index)
	index+=1
end
index=1
for letter in ('а'..'я') do
	alphabat1.store(letter, index)
	index+=1
end

puts alphabat1 
puts "\n"
puts alphabat2