=begin
  
Класс Route (Маршрут):
Имеет начальную и конечную станцию, а также список промежуточных станций. 
    Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной
  
=end


class Route 
  @@routes = 0
  def initialize(start_st, end_st)
    @@routes+= 1
    @stations=[start_st, end_st]
  end
#добовляем промежуточные станции
  def get_st (name)
    @stations.insert(-2, name)
  end

#удаление станции из маршрута
  def del_st (name)
    puts "Станция #{name} удалена из маршрута" if @stations.delete(name)!= nil
    return name
  end
#вывод списка всех станций по порядку
  def print_st
    print "Полный маршрут: "
    @stations.each_index { |i| print " #{@stations[i]} " } 
    puts ""   
  end
end