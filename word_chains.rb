def adjacent_words(current_word, dictionary)
  dictionary.keep_if do |dict_word|
    next unless dict_word.length == current_word.length

    letters_off = 0
    dict_word.split(//).each_with_index do |letter, index|
      letters_off += 1 unless current_word[index] == letter
    end
    letters_off == 1 ? true : false
  end

  dictionary
end

dict = File.readlines('dictionary.txt')
dict.map! { |word| word.chomp }

p adjacent_words("house", dict)