_   = require('underscore')
fs  = require('fs')

class Scrabble
  directions:
    down: [1, 0]
    right: [0, 1]

  winner:
    word: ''
    coordinates: []
    value: 0
    direction: []

  tileValues: {}

  constructor: (path) ->
    @file       =  @open(path)
    @dictionary =  @file.dictionary
    @tiles      =  []
    @tileParser(@file.tiles)
    @board      =  @boardParser(@file.board)

  open: (path) ->
    try
      path = process.cwd() + path
      JSON.parse fs.readFileSync(path, 'utf8')
    catch error
      # console.log('The file %s could not be found.', path)
      return false

  tileParser: (tiles) ->
    _.each tiles, (value) =>
      letter = value[0]
      @tiles.push(letter)
      @tileValues[letter] = parseInt(value[1..])

  boardParser: (board) ->
    _.map board, (item) ->
      _.map item.split(' '), (number) -> parseInt(number)

  squareValue: (coordinates) ->
    @board[coordinates[0]][coordinates[1]]

  nextCoordinate: (coordinates, index, direction) ->
    _.map coordinates, (coordinate, i) =>
      f = (@directions[direction][i] * index)

  checkScore: (word, startCoordinates, direction) ->
    letters = word.split('')
    score   = 0

    _.each letters, (letter, index) =>
      next = @nextCoordinate(startCoordinates, index, direction)
      value = @tileValues[letter]
      score += @squareValue(next) * value

    if isNaN(score) then false else score

  searchRow: (word, coordinates, direction) ->
    moveCount = @movesForDirection(word, direction)
    while moveCount -= 1
      startCoordinates = @nextCoordinate(coordinates, moveCount, direction)
      score = @checkScore(word, startCoordinates, direction)
      @isWinner(word, startCoordinates, direction, score)

  searchRows: (word) ->
    _.each ['right', 'down'], (direction) =>
      count = @boardSize(direction)

      while count -= 1
        @searchRow(word, @coordinatesForIndex(count, direction), direction)

  coordinatesForIndex: (index, direction) ->
    if direction is 'right' then [index, 0] else [0, index]

  isWinner: (word, coordinates, direction, score) ->
    if score > @winner.value
      @winner =
        word: word
        coordinates: coordinates
        direction: @directions[direction]
        value: score

  crawlBoard: ->
    _.each @dictionary, (word, index) =>
      console.log word
      @searchRows(word) if @wordCanBePlayed(word)

  boardSize: (direction) ->
    switch direction
      when 'right' then @board[0].length
      when 'down'  then @board.length

  wordCanBePlayed: (word) ->
    goodLetter = 0
    letters = word.split('')
    _.each letters, (letter) =>
      goodLetter++ if @tileValues[letter]
    return letters.length == goodLetter && letters.length <= @boardSize('right') && letters.length <= @boardSize('down')

  movesForDirection: (word, direction) ->
    wordLength = word.length
    size = @boardSize(direction)
    if wordLength <= size then (size - wordLength + 1) else 0

module.exports = Scrabble
