=begin
Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара (может быть нецелым числом). 
Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве названия товара. 
На основе введенных данных требуетеся:
Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара. 
Также вывести итоговую сумму за каждый товар.
Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".
=end

list = Hash.new(nil)
total = 0

loop do
  print "Введите название товара - "
  product = gets.chomp
  break if product == "стоп"
  print "Введите цену за единицу - "
  price = gets.chomp.to_f
  print "Введите количество купленного товара (#{product}) -  "
  count_product = gets.chomp.to_f

  total_price_product = price*count_product
#заполняем хэш

  list[product] = {
    price: price,
    count: count_product,
    price_product: total_price_product
    }
    total += total_price_product
end
puts list
puts "\n"
puts "Общая стоимость товара - #{total}"