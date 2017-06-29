class PasswordBuilder

  MIN_WORD_COUNT = 3

  class << self

    def generate(word_list)
      word_array = word_list.split(',')
      size = word_array.size
      word_array.permutation(word_array.size).to_a.map(&:join) if size >= MIN_WORD_COUNT
    end
  end
end
