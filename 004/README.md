## Anonymizing Zipcode-like-number: 43690

Ruby trivia:

    "1010101010101010".to_i(2)

## Installing

Use .rvmrc if you wish.

As flog hates ruby 1.9.3 hash syntax, this project also works under ruby 1.8.7

Standard bundler:

    bundle install

## Testing

Run rake:

    rake

## Usage

Run scrabble.rb with input and output file arguments:

  bundle exec ./scrabble.rb INPUT.json OUTPUT.txt

## Flog

Run flog directly:

    flog *.rb lib/*.rb

Or use rake:

    rake flog

Flog output:
 
    259.2: flog total
      4.9: flog/method average
    
     10.7: Board#apply_word_to_board_strings lib/board.rb:107
     10.5: Board#calculate_segment_score    lib/board.rb:85
     10.5: Position#initialize              lib/position.rb:27
     10.4: Board#find_word_scores_in_row    lib/board.rb:74
     10.0: Board#render                     lib/board.rb:36
      9.3: Scrabble#parse                   scrabble.rb:45
      9.2: Board#scan_board                 lib/board.rb:65
      9.0: Dictionary#word_to_scores        lib/dictionary.rb:35
      9.0: main#none
      8.4: Position::find_optimal           lib/position.rb:21
      7.7: Runner::run                      scrabble.rb:63
      7.4: Tiles#initialize                 lib/tiles.rb:9
      7.3: Tiles#add_tile                   lib/tiles.rb:15
      6.7: Dictionary#word_to_scores_or_nil_if_different_lengths lib/dictionary.rb:50
      6.6: Board#to_array                   lib/board.rb:21
      6.4: Dictionary#possibilities         lib/dictionary.rb:21
      6.2: Runner::carousel                 scrabble.rb:71
      5.8: Board#split_row                  lib/board.rb:25
      5.6: Board#calculate_word_score       lib/board.rb:81

