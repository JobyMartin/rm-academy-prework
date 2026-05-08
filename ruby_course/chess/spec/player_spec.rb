require_relative '../lib/player'

describe Player do
  it "has name and color" do
    player = Player.new('Joby', 'black')
    expect(player.name).to eq('Joby')
    expect(player.color).to eq('black')
  end
end
