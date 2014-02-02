def adjacent_words(root_word, dictionary)
  dictionary.dup.tap do |selective_dictionary|

    selective_dictionary.keep_if do |dict_word|
      letters_off = 0
      dict_word.split(//).each_with_index do |letter, index|
        letters_off += 1 unless root_word[index] == letter
      end
      letters_off == 1 ? true : false
    end
  end
end

def same_length(word, dictionary)
  dictionary.keep_if { |dict_word| word.length == dict_word.length }
end

def explore_words(source, dictionary)
  words_to_expand = [source]
  all_reachable_words = [source]
  candidate_words = same_length(source, dictionary)
  p "EXPAND_LENGTH = 1"
  p "REACH Length = 1"
  p "candidates = #{candidate_words.length}"

  until words_to_expand.empty?
    current_word = words_to_expand.shift
    current_word_children = adjacent_words(current_word, candidate_words)
    current_word_children.each do |child_word|
      words_to_expand << child_word
      all_reachable_words << child_word
      candidate_words.delete(child_word)
    end
  end

  p "reachable #{all_reachable_words.length}"
  p "candidates #{candidate_words.length}"
  all_reachable_words
end

dict = File.readlines('dictionary.txt')
dict.map! { |word| word.chomp }

explore_words("duck", dict)