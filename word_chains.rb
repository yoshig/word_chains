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

def find_chain(source, target, dictionary)
  words_to_expand = [source]
  parents = {}
  candidate_words = same_length(source, dictionary)

  until words_to_expand.empty?
    current_word = words_to_expand.shift
    current_word_children = adjacent_words(current_word, candidate_words)
    current_word_children.each do |child_word|
      unless parents.include?(child_word)
        words_to_expand << child_word
        parents[child_word] = current_word
        candidate_words.delete(child_word)
        return parents if child_word == target
      end
    end
  end

  nil
end

dict = File.readlines('dictionary.txt')
dict.map! { |word| word.chomp }

p find_chain("duck", "ruby", dict)