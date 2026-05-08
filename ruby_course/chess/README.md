# Chess

A terminal-run Chess game.

## Getting Started

1. Clone the repository
2. Change directory to the project folder:
```bash
cd ruby_course/chess
```
3. Play the game:
```bash
ruby main.rb
```

## Usage

* Enter player names
* Enter starting coordinates followed by ending coordinates to move a piece
* Enter "SAVE" at any time to save the game

## Technologies Used

* Ruby
* RSpec
* Marshal (for serialization)

## Notes

* Does not handling castling, en passant, or pawn promotion
* The board never inverts; white will always be displayed on the bottom, and black on the top