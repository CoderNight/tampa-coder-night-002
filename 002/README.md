Brute force rushed just to make it work in time to pay price of admission.
This is basically working pseudo code with no form of refactoring, but I
haven't had time due to trying to catch up with work after being away.

### Usage

```
game = Scrabble.new_game(path_to_file) # or Scrabble.new_game(json)
game.play(game.best_move)
game.to_s
```


