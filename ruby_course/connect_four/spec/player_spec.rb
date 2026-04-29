require './src/player'

RSpec.describe Player do
  let(:player) { Player.new("Joby", "X") }

  describe '#initialize' do
    it 'creates a player with a name' do
      expect(player.name).to eq("Joby")
    end

    it 'creates a player with a symbol' do
      expect(player.symbol).to eq("X")
    end
  end
end
