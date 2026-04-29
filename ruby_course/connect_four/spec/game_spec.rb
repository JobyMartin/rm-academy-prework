require './src/game'

RSpec.describe Game do
  let(:game) { Game.new }

  describe '#create_player' do
    it 'creates a player with a name and symbol' do
      game.create_player('Joby', 'X')
      game.create_player('Josh', 'O')

      expect(game.players[0].name).to eq('Joby')
      expect(game.players[0].symbol).to eq('X')

      expect(game.players[1].name).to eq('Josh')
      expect(game.players[1].symbol).to eq('O')
    end
  end

  describe "#set_current_player" do
    fit "sets the currect player to the repsective player's turn" do
      game.current_player = game.players[0]
      expect(game.set_current_player).to eq(game.players[1])

      game.current_player = game.players[1]
      expect(game.set_current_player).to eq(game.players[0])
    end
  end
  
  describe '#get_move' do
  it 'prompts the player and returns their move' do
    game.create_player('Joby', 'R')
    game.create_player('Josh', 'Y')
    game.current_player = game.players.sample
    allow(game).to receive(:gets).and_return("4\n")
  
    expect { game.get_move }
      .to output("#{game.current_player.name} (#{game.current_player.symbol == 'R' ? 'Red' : 'Yellow'}), enter your move: ").to_stdout 
  
    expect(game.get_move).to eq(4)
  end
  end

  describe "#setup" do
    it 'promts the players for names' do
      allow(game).to receive(:gets).and_return("Joby R, Josh Y\n")
  
      expect { game.setup }
        .to output("Enter the names of the 2 players and their colors (R for red, Y for yellow) separated by a comma (Joby R, Josh Y): ").to_stdout
    end

    it 'creates players' do
      allow(game).to receive(:gets).and_return("Joby R, Josh Y\n")
      game.setup

      expect(game.players[0].name).to eq('Joby')
      expect(game.players[0].symbol).to eq('R')

      expect(game.players[1].name).to eq('Josh')
      expect(game.players[1].symbol).to eq('Y')
    end
  end

  describe '#turn' do
    let (:board) { game.board }
    before do
      game.create_player('Joby', 'R')
      game.create_player('Josh', 'Y')

      # ensure set_current_player picks player 1
      game.current_player = game.players[1]

      allow(board).to receive(:display)
      allow(board).to receive(:column_full?).and_return(false)
      allow(board).to receive(:drop_piece)
    end

    it 'switches players and drops the current player piece in the chosen column' do
      allow(game).to receive(:gets).and_return(double(chomp: '3'))

      game.turn

      expect(game.current_player).to eq(game.players[0])
      expect(board).to have_received(:display)
      expect(board).to have_received(:drop_piece).with(2, 'R')
    end

    it 'asks again if move is outside 1-7' do
      allow(game).to receive(:gets).and_return(
        double(chomp: '9'),
        double(chomp: '4')
      )

      game.turn

      expect(board).to have_received(:drop_piece).with(3, 'R')
    end

    it 'asks again if chosen column is full' do
      allow(game).to receive(:gets).and_return(
        double(chomp: '2'),
        double(chomp: '5')
      )

      allow(board).to receive(:column_full?).and_return(true, false)

      game.turn

      expect(board).to have_received(:drop_piece).with(4, 'R')
    end
  end
end
