require 'scrabble'

describe "8-best-scrabble-opening" do

  describe "given the example json board input file" do
    let(:input_json) {
      json = '
      {
        "board": [
          "1 1 1 1 1 1 1 1 1 1 1 1",
          "1 1 1 2 1 2 1 1 1 1 1 1",
          "1 2 1 1 1 3 1 1 1 1 2 1",
          "2 1 1 1 1 1 1 1 1 2 2 1",
          "1 1 1 2 1 1 1 1 1 1 1 1",
          "1 1 1 1 1 1 2 1 1 1 2 1",
          "1 1 1 1 1 1 1 1 2 1 1 1",
          "1 1 1 1 1 1 1 1 1 1 1 2",
          "1 1 1 1 1 1 1 1 1 1 1 1"
        ],
        "dictionary": [
          "gyre",
          "gimble",
          "wabe",
          "mimsy",
          "borogoves",
          "raths",
          "outgrabe",
          "jabberwock",
          "jubjub",
          "shun",
          "frumious",
          "bandersnatch",
          "vorpal",
          "manxome",
          "foe",
          "tumtum",
          "uffish",
          "whiffling",
          "tulgey",
          "burbled",
          "galumphing",
          "frabjous",
          "callooh",
          "callay",
          "chortled",
          "brillig",
          "slithy",
          "toves",
          "gyre",
          "gimble",
          "mome"
        ],
        "tiles": [
          "i4",
          "w5",
          "g6",
          "f7",
          "s2",
          "e1",
          "l3",
          "h8",
          "n1",
          "f7",
          "b8",
          "r12",
          "u3",
          "g6",
          "i4",
          "q9",
          "o3",
          "d2",
          "s2",
          "f7"
        ]
      }'
      json.gsub(/\n      /m,"\n")
    }

    let(:board_array_of_arrays) {
      [
        [1,1,1,1,1,1,1,1,1,1,1,1],
        [1,1,1,2,1,2,1,1,1,1,1,1],
        [1,2,1,1,1,3,1,1,1,1,2,1],
        [2,1,1,1,1,1,1,1,1,2,2,1],
        [1,1,1,2,1,1,1,1,1,1,1,1],
        [1,1,1,1,1,1,2,1,1,1,2,1],
        [1,1,1,1,1,1,1,1,2,1,1,1],
        [1,1,1,1,1,1,1,1,1,1,1,2],
        [1,1,1,1,1,1,1,1,1,1,1,1]
     ]
    }

    let(:input_hash) {
      {
        :board => [
            "1 1 1 1 1 1 1 1 1 1 1 1",
            "1 1 1 2 1 2 1 1 1 1 1 1",
            "1 2 1 1 1 3 1 1 1 1 2 1",
            "2 1 1 1 1 1 1 1 1 2 2 1",
            "1 1 1 2 1 1 1 1 1 1 1 1",
            "1 1 1 1 1 1 2 1 1 1 2 1",
            "1 1 1 1 1 1 1 1 2 1 1 1",
            "1 1 1 1 1 1 1 1 1 1 1 2",
            "1 1 1 1 1 1 1 1 1 1 1 1"
        ],
        :dictionary => [
          "gyre",
          "gimble",
          "wabe",
          "mimsy",
          "borogoves",
          "raths",
          "outgrabe",
          "jabberwock",
          "jubjub",
          "shun",
          "frumious",
          "bandersnatch",
          "vorpal",
          "manxome",
          "foe",
          "tumtum",
          "uffish",
          "whiffling",
          "tulgey",
          "burbled",
          "galumphing",
          "frabjous",
          "callooh",
          "callay",
          "chortled",
          "brillig",
          "slithy",
          "toves",
          "gyre",
          "gimble",
          "mome"
        ],
        :tiles => [
          "i4",
          "w5",
          "g6",
          "f7",
          "s2",
          "e1",
          "l3",
          "h8",
          "n1",
          "f7",
          "b8",
          "r12",
          "u3",
          "g6",
          "i4",
          "q9",
          "o3",
          "d2",
          "s2",
          "f7"
        ]
      }
    }

    let(:output_board) {
      [ "1 1 1 1 1 1 1 1 1 1 1 1",
        "1 1 1 2 1 2 1 1 1 1 1 1",
        "1 2 w h i f f l i n g 1",
        "2 1 1 1 1 1 1 1 1 2 2 1",
        "1 1 1 2 1 1 1 1 1 1 1 1",
        "1 1 1 1 1 1 2 1 1 1 2 1",
        "1 1 1 1 1 1 1 1 2 1 1 1",
        "1 1 1 1 1 1 1 1 1 1 1 2",
        "1 1 1 1 1 1 1 1 1 1 1 1" ].join("\n")
    }

    let(:optimal_starting_position) {
      {
        :orientation => :horizontally,
              :score => 65,
               :word => "whiffling",
                  :x => 2,
                  :y => 2
      }
    }

    describe "Unit Tests" do

      describe "Tiles" do

        let(:tiles_alphabet_score_hash) {
          {
            'i' => [ 4, 4 ],
            'w' => [ 5 ],
            'g' => [ 6, 6 ],
            'f' => [ 7, 7, 7 ],
            's' => [ 2, 2 ],
            'e' => [ 1 ],
            'l' => [ 3 ],
            'h' => [ 8 ],
            'n' => [ 1 ],
            'b' => [ 8 ],
            'r' => [ 12 ],
            'u' => [ 3 ],
            'q' => [ 9 ],
            'o' => [ 3 ],
            'd' => [ 2 ],
          }
        }
  
  
        it "#new processes input tiles into Tiles with scores" do
          tiles=Tiles.new(input_hash[:tiles])
          tiles_alphabet_score_hash.each_pair do |letter, scores|
            tiles.scores(letter).should eq(scores)
          end
        end
  
        it "#have? checks for letters" do
          tiles=Tiles.new(input_hash[:tiles])
          tiles_alphabet_score_hash.each_pair do |letter, scores|
            tiles.have?(letter).should eq(true)
          end
        end
  
        it "#scores checks the scores of a letter" do
          tiles=Tiles.new(input_hash[:tiles])
          tiles_alphabet_score_hash.each_pair do |letter, scores|
            tiles.scores(letter).should eq(scores)
          end
        end
  
        it "#use allocates a letter" do
          tiles=Tiles.new(input_hash[:tiles])
          tiles_alphabet_score_hash.each_pair do |letter, scores|
            tiles.use(letter)
            score=scores.shift
            tiles.scores(letter).should eq(scores)
            scores << score
          end
        end
  
        it "#add_score returns scores with a letter score appended" do
          tiles=Tiles.new(input_hash[:tiles])
          tiles_alphabet_score_hash.each_pair do |letter, scores|
            scores_after=scores.clone
            scores_after << scores.first
            tiles.add_score(scores, letter).should eq(scores_after)
          end
        end
  
      end
  
      describe "Dictionary" do
  
        let(:dictionary_word_score_array_hash) {
          {
                 'shun' => [2, 8, 3, 1],
                  'foe' => [7, 3, 1],
              'uffish' => [3, 7, 7, 4, 2, 8],
            'whiffling' => [5, 8, 4, 7, 7, 3, 4, 1, 6]
          }
        }
  
        before(:each) do
          @dictionary=Dictionary.new(input_hash[:dictionary])
          @tiles=Tiles.new(input_hash[:tiles])
          @dictionary.use_tiles! @tiles
        end
  
        it "#use_tiles! stores tiles for future use" do
          @dictionary.use_tiles! @tiles
          @dictionary.tiles.should eq(@tiles)
        end

        it "#possibilities returns the possible words and their scores" do
          @dictionary.possibilities.should eq(dictionary_word_score_array_hash)
        end
  
        it "#words returns the possible words available with our given Tiles" do
          @dictionary.words.should eq(dictionary_word_score_array_hash.keys.map { |m| m.to_s } )
        end
  
        it "#scores_for_word returns the word scores for our possible words" do
            dictionary_word_score_array_hash.each_pair do |word, scores|
            @dictionary.scores_for_word(word).should eq(scores)
          end
        end
  
      end

      describe "Position" do
        let(:position) { Position.new(optimal_starting_position) }
          
        it "Position#new_parameterized passes to new" do
          Position.should_receive(:new).with({
                                    :orientation => optimal_starting_position[:orientation],
                                          :score => optimal_starting_position[:score],
                                           :word => optimal_starting_position[:word],
                                              :x => optimal_starting_position[:x],
                                              :y => optimal_starting_position[:y] })
          parameterized=Position.new_parameterized( optimal_starting_position[:orientation],
                                                    optimal_starting_position[:score],
                                                    optimal_starting_position[:word],
                                                    optimal_starting_position[:x],
                                                    optimal_starting_position[:y] )
        end

        it "Position#find_optimal finds the optimal word for a given board and dictionary" do
          tiles=Tiles.new(input_hash[:tiles])
          dictionary=Dictionary.new(input_hash[:dictionary])
          dictionary.use_tiles! tiles
          board=Board.new(input_hash[:board])
          board.use_dictionary! dictionary
          optimal_position=Position.find_optimal(board, dictionary)
          position=Position.new(optimal_starting_position)
          optimal_position.attributes.should eq(position.attributes)
        end

        it "#new initializes attributes given a symbol hash" do
          position.x.should eq(optimal_starting_position[:x])
          position.y.should eq(optimal_starting_position[:y])
          position.word.should eq(optimal_starting_position[:word])
          position.score.should eq(optimal_starting_position[:score])
          position.orientation.should eq(optimal_starting_position[:orientation])
        end

        it "#attributes stores the input hash passed to new" do
          position=Position.new({
                     :orientation => optimal_starting_position[:orientation],
                           :score => optimal_starting_position[:score],
                            :word => optimal_starting_position[:word],
                               :x => optimal_starting_position[:x],
                               :y => optimal_starting_position[:y] })
          position.attributes.should eq(optimal_starting_position)
        end
  
      end
  
      describe "Board" do
  
        let(:board) { Board.new(input_hash[:board]) }

        it "#use_dictionary! stores dictionary for future use" do
          dictionary=Dictionary.new(input_hash[:dictionary])
          board.use_dictionary! dictionary
          board.dictionary.should eq(dictionary)
        end

        it "#to_array returns an array of arrays" do
          board.to_array.should eq(board_array_of_arrays)
        end

        it "#render outputs a position on the board" do
          board.should_receive(:to_array).and_return(board_array_of_arrays)
          position=Position.new(optimal_starting_position)
	  board.render(position).should eq(output_board)
        end

      end
  
      describe "Scrabble" do
  
        let(:scrabble) { Scrabble.new }
  
        it "processes an input file" do
          input_json='{}'
          # Stub out the input file
          File.stub!(:new).and_return(input_json)
          # Stub out the output file
          output_file=stub
          File.stub!(:open).and_return(output_file)
          output_file.stub!(:write)
          output_file.stub!(:close)
          output_hash={}
          parser=stub
          parser.stub!(:parse).and_return(output_hash)
          scrabble.should_receive(:read_input_json).with('input filename')
          scrabble.stub!(:process)
          scrabble.stub!(:write_outboard_board)
          Yajl::Parser.stub!(:new).and_return(parser)
          scrabble.run('input filename','output filename')
        end
  
        it "processes an empty json input file" do
          input_json='{ "board": [], "dictionary": [], "tiles": [] }'
          # Stub out the input file
          File.stub!(:new).and_return(input_json)
          # Stub out the output file
          output_file=stub
          File.stub!(:open).and_return(output_file)
          output_file.stub!(:write)
          output_file.stub!(:close)
          input_hash={ :board => [], :dictionary => [], :tiles => [] }
          scrabble.stub!(:process)
          scrabble.stub!(:write_outboard_board)
          scrabble.run('input filename','output filename')
        end
  
        it "processes input json" do
          File.stub!(:new).and_return(input_json)
          Tiles.stub!(:new)
          dictionary=stub
          dictionary.stub!(:use_tiles!)
          Dictionary.stub!(:new).and_return(dictionary)
          Board.stub!(:new)
          Board.stub!(:render)
          # Verify that the process method is called
          scrabble.should_receive(:process).with(input_hash)
          scrabble.run('input filename', 'output filename')
        end
   
      end
  
    end

    describe "Integration Tests" do

      it "outputs correct text board result" do
        # Stub out the input file
        File.stub!(:new).and_return(input_json)
        # Stub out the output file
        output_file=stub
        output_file.should_receive(:write).with(output_board)
        output_file.stub!(:close)
        File.stub!(:open).and_return(output_file)
        # Run it
        Scrabble.new.run('input filename', 'output filename')
      end

    end
      
  end
end
