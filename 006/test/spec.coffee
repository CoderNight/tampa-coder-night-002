vows     = require("vows")
assert   = require("assert")
Scrabble = require("../app")

vows
  .describe("Scrabble")
  .addBatch

    "An instance of Scrabble":
      topic: new Scrabble("/assets/INPUT.json")

      "should open a json file and return an object": (scrabble) ->
        assert.equal typeof scrabble.file, "object"

      "should have an array of words from the dictionary": (scrabble) ->
        assert.equal scrabble.dictionary[0], 'amalar'

      "should have an object of tiles and value": (scrabble) ->
        assert.equal scrabble.tileValues.i, 4

      "should have a board array of tile values": (scrabble) ->
        assert.equal scrabble.board[0][0], 1

      "should calculate the value of the first word on the top left of the board": (scrabble) ->
        assert.equal scrabble.checkScore("whiffling", [0,0], 'right'), 68

      "should return false if the word contains letters that don't exist": (scrabble) ->
        assert.equal scrabble.checkScore('gyre', [0,0], 'right'), false

      "should calculate the number of possible moves per line going right": (scrabble) ->
        assert.equal scrabble.movesForDirection('whiffling', 'right'), 4

      "should calculate the number of possible moves per line going down": (scrabble) ->
        assert.equal scrabble.movesForDirection('whiffling', 'down'), 1

      "should calculate the most valuble play for a word for the first row": (scrabble) ->
        scrabble.searchRow('whiffling', [0,0], 'right')
        assert.equal scrabble.winner.value, 71

      "should calculate the most valuble play for all of the rows": (scrabble) ->
        scrabble.searchRows('whiffling')
        assert.equal scrabble.winner, [2, 2]

      "should crawl the board": (scrabble) ->
        scrabble.crawlBoard()
        assert.equal scrabble.winner, 'foo'

  .addBatch
    "An invalid instance of Scrabble":
      topic: new Scrabble('bad/path/to.json')

      "should fail to read the file gracefully": (scrabble) ->
        assert.equal scrabble.open("foobar"), false

  .export(module)
