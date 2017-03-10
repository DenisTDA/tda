#Задача 4 в 1 теме.
puts "Дано квадратное уровнение вида: ax^2 + bx + c =0, где a, b, c - коэффициенты"
puts "Для вычисления Вашего уровнения введите коэфициенты:"
print "введите коэфициент а = "
a=gets.chomp.to_f
print "введите коэфициент b = "
b=gets.chomp.to_f
print "введите коэфициент c = "
c=gets.chomp.to_f
#вычисляем дискриминант
dis=b**2-4*a*c
if dis<0
	puts "Ваше уровнение не имеет решений. Дискриминант отрицательный и равен D = #{dis}"
elsif dis==0
	puts "Ваше уровнение имеет одно решение:"
	puts "Дискриминант равен D = 0"
	puts "Корень уравнения x = #{-b/(2*a)}"
else
	puts "Ваше уровнение имеет два решения:"
	puts "Дискриминант равен D = #{dis}"
	puts "Первый корень уравнения x1 = #{(-b-Math.sqrt(dis))/(2*a)}"
	puts "Второй корень уравнения x2 = #{(-b+Math.sqrt(dis))/(2*a)}"
end
