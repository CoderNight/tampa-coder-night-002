module Scrabble
  class Board

    def initialize(arr = [])
      @layout = arr
    end

    def place_in_best_position!(word)
      alignment, row, pos = find_best_position(word)
      new_row = alignment == :rightways ? rightways[row] : sideways[row]
      word.letters.each_with_index do |letter, index|
        new_row[pos+index] = letter
      end
      @layout[row] = new_row.join(" ")
      layout
    end

    def find_best_position(word)
      high_val = 0
      alignment = :rightways
      high_row = 0
      position = 0
      if rightways_row_length >= word.length
        rightways.each_with_index do |row, index|
          new_score, pos = get_high_score_and_position_for_row(word, row)
          if new_score > high_val
            high_val = new_score
            high_row = index
            position = pos
          end
        end
      end
      if sideways_row_length >= word.length
        sideways.each_with_index do |row, index|
          new_score, pos = get_high_score_and_position_for_row(word, row)
          if new_score > high_val
            high_val = new_score
            alignment = :sideways
            high_row = index
            position = pos
          end
        end
      end
      [alignment, high_row, position]
    end

    def rightways
      layout.map {|row| row.split(" ")}
    end

    def rightways_row_length
      rightways.first.size
    end

    def sideways_row_length
      sideways.first.size
    end

    def sideways
      n = []
      layout.each_with_index do |row, rindex|
        row.split(" ").each_with_index do |col, cindex|
          n.insert(cindex, []) if n[cindex].nil?
          n[cindex].insert(rindex, col)
        end
      end
      n
    end

    def sideways_display
      sideways.each {|r| p r.join(" ")}
    end

    def get_high_score_and_position_for_row(word, row)
      high = 0
      high_pos = 0
      row.size.times do |i|
        if high < calculate_score_for(word, row, i)
          high = calculate_score_for(word, row, i)
          high_pos = i
        end
      end
      [high, high_pos]
    end

    def calculate_score_for(word, row = [], position = 0)
      return 0 if row.size - position < word.length
      score = 0
      word.tiles.each_with_index do |tile, index|
        score += row[index+position].to_i * tile.value
      end
      score
    end

    def layout
      @layout
    end
  end
end