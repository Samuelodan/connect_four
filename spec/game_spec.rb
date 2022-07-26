# frozen_string_literal

require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

RSpec.describe Game do
  subject(:game) { described_class.new(board, player1, player2) }
  let(:board) { Board.new }
  let(:player1) { Player.new }
  let(:player2) { Player.new }

  describe '#assign_symbol' do
    context 'for player1' do
      it "sends #set_symbol to player1" do
        desired_symbol = "\e[91m\u25CF\e[0m"
        expect(player1).to receive(:set_symbol).with(desired_symbol)
        game.assign_symbol
      end
    end
  end

  describe '#assign_symbol' do
    context 'for player2' do
      it "sends #set_symbol to player2" do
        desired_symbol = "\e[37m\u25CF\e[0m"
        expect(player2).to receive(:set_symbol).with(desired_symbol)
        game.assign_symbol
      end
    end
  end

  describe '#assign_names' do
    context 'for player 1' do
      it "Changes player1's name from nil" do
        desired_name = 'Player1'
        expect { game.assign_names }.to change { game.player1.name }.from(nil).to(desired_name)
      end
    end

    context 'for player 2' do
      it "Changes player2's name from nil" do
        desired_name = 'Player2'
        expect { game.assign_names }.to change { game.player2.name }.from(nil).to(desired_name)
      end
    end
  end
end
