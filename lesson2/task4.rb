#Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

alphabet = "a".."z"
vowels = [ "a", "e", "i", "o", "u" ]
hash_vowels = {}
alphabet.each_with_index { |char, index| hash_vowels[char] = index+1 if vowels.include?(char) }
puts hash_vowels