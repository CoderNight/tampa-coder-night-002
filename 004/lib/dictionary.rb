#   ____  _      _   _                              
#  |  _ \(_) ___| |_(_) ___  _ __   __ _ _ __ _   _ 
#  | | | | |/ __| __| |/ _ \| '_ \ / _` | '__| | | |
#  | |_| | | (__| |_| | (_) | | | | (_| | |  | |_| |
#  |____/|_|\___|\__|_|\___/|_| |_|\__,_|_|   \__, |
#                                             |___/ 
#
class Dictionary

  attr_reader :tiles

  def initialize dictionary
    @dictionary=dictionary
    @tiles=Tiles.new
  end

  def use_tiles! tiles
    @tiles=tiles
  end

  def possibilities
    @possibilities||=@dictionary.inject({}) do |possibilities, word|
      add_word(possibilities, word)
    end
  end

  def words
    possibilities.keys
  end

  def scores_for_word word
    possibilities[word]
  end

  def word_to_scores word
    tiles=@tiles.clone
    word_scores=word.split(//).inject([]) do |scores, letter|
      tiles.add_score(scores, letter)
    end
  end

private

  def add_word possibilities, word
    scores=word_to_scores_or_nil_if_different_lengths(word)
    possibilities[word] = scores if scores
    possibilities
  end

  def word_to_scores_or_nil_if_different_lengths word
    word_scores=word_to_scores(word)
    word_scores.length == word.length ? word_scores.clone : nil
  end

end
