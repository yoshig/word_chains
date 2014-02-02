class WordChain
  attr_accessor :source, :target

  def initialize
    @dictionary = File.readlines('dictionary.txt')
    @dictionary.map! { |word| word.chomp }
    @source = ""
    @target = ""
  end

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
    @dictionary.dup.keep_if { |dict_word| word.length == dict_word.length }
  end

  def find_chain
    words_to_expand = [@source]
    parents = {}
    candidate_words = same_length(@source, @dictionary)

    until words_to_expand.empty?
      current_word = words_to_expand.shift
      adjacent_words(current_word, candidate_words).each do |child_word|
        unless parents.include?(child_word)
          words_to_expand << child_word
          parents[child_word] = current_word
          candidate_words.delete(child_word)
          return parents if child_word == @target
        end
      end
    end

    nil
  end

  def build_path_from_breadcrumbs
    return nil unless @source.length == @target.length 
    return @source if @source == @target
    all_paths = find_chain
    return all_paths if all_paths.nil?
    path_word = @target

    [@target].tap do |true_path|
      until path_word == @source
        path_word = all_paths[path_word]
        true_path << path_word
      end
    end
  end
end

wc = WordChain.new
wc.target = "ruby"
wc.source = "duck"
p wc.build_path_from_breadcrumbs