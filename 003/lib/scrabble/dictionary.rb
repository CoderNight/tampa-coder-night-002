module Scrabble
  class Dictionary
    attr_accessor :words

    def initialize(args)
      self.words = args.map {|arg| Word.new(arg)}
    end

    def valid_words
      words.select {|word| !word.invalid?}
    end

    def most_valuable_word
      valid_words.sort {|x,y| y.value <=> x.value}.first
    end
  end
end