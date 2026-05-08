# CRC Cards for a game of Chess

-----------------
Class: Player
-----------------
Responsibilities:
has name
has color
-----------------
Collaborators:
Game
-----------------


-----------------
Class: Piece
-----------------
Responsibilities:
has color
has symbol
knows current location
-----------------
Collaborators:
Game
-----------------


-----------------
Class: Board
-----------------
Responsibilities:
has many pieces
has algebraic notation (a-h for columns, 1-8 for rows)
handles piece movement
knows correct moves
knows check
knows checkmate
knows stalemate
-----------------
Collaborators:
Game
-----------------


-----------------
Class: Game
-----------------
Responsibilities:
has 2 players
has a board
knows current player
handles turns
* gets input
* moves piece
handles saving and serializing
-----------------
Collaborators:
Board
Player
-----------------
