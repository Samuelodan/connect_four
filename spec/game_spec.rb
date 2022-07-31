# frozen_string_literal

require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

RSpec.describe Game do
  subject(:game) { described_class.new(
                      board: board,
                      player1: player1,
                      player2: player2)
                  }
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
      it "sends #set_name to player1" do
        desired_name = 'Player1'
        expect(player1).to receive(:set_name).with(desired_name)
        game.assign_names
      end
    end

    context 'for player 2' do
      it "sends #set_name to player2" do
        desired_name = 'Player2'
        expect(player2).to receive(:set_name).with(desired_name)
        game.assign_names
      end
    end
  end

  describe '#change_turn' do
    context 'when current_player is player1' do
      it 'makes player2 the current_player' do
        expect { game.change_turn }.to change { game.current_player }. from(game.player1).to(game.player2)
      end
    end
  end

  describe '#change_turn' do
    context 'when current_player is player2' do
      before do
        game.instance_variable_set(:@current_player, player2)
      end

      it 'makes player1 the current_player' do
        expect { game.change_turn }.to change { game.current_player }. from(game.player2).to(game.player1)
      end
    end
  end

  describe '#get_input' do
    before do
      prompt = ', enter a column number between 1 and 7'
      prompt2 = 'or enter `quit` to exit game.'
      allow(game).to receive(:print)
      allow(game).to receive(:puts).with(prompt)
      allow(game).to receive(:puts).with(prompt2)
    end

    context 'when player enters invalid column number once' do
      before do
        invalid = '9'
        valid = '4'
        allow(game).to receive(:gets).and_return(invalid, valid)
      end

      it 'alerts player once' do
        message = 'enter a valid column number between 1 and 7'
        expect(game).to receive(:puts).with(message).once
        game.get_input
      end
    end

    context 'when player enters invalid column number twice' do
      before do
        invalid = '9'
        valid = '4'
        allow(game).to receive(:gets).and_return(invalid, invalid, valid)
      end

      it 'alerts player twice' do
        message = 'enter a valid column number between 1 and 7'
        expect(game).to receive(:puts).with(message).twice
        game.get_input
      end
    end

    context 'when player enters valid column number' do
      before do
        valid = '4'
        allow(game).to receive(:gets).and_return(valid)
      end

      it 'does not alert player' do
        message = 'enter a valid column number between 1 and 7'
        expect(game).to_not receive(:puts).with(message)
        game.get_input
      end
    end

    context 'when player input is valid but column is already filled' do
      before do
        filled = '2'
        available = '3'
        allow(game).to receive(:gets).and_return(filled, available)
        allow(board).to receive(:column_full?).and_return(true, false)
      end

      it 'alerts player' do
        message = 'this column is full. Try another column'
        expect(game).to receive(:puts).with(message).once
        game.get_input
      end
    end

    context 'when column is already filled twice' do
      before do
        filled = '2'
        available = '3'
        allow(game).to receive(:gets).and_return(filled, filled, available)
        allow(board).to receive(:column_full?).and_return(true, true, true, false)
      end

      it 'alerts player twice' do
        message = 'this column is full. Try another column'
        expect(game).to receive(:puts).with(message).twice
        game.get_input
      end
    end

    context 'when column has available slots' do
      before do
        filled = '5'
        available = '6'
        allow(game).to receive(:gets).and_return(available)
        allow(board).to receive(:column_full?).and_return(false)
      end

      it 'does not alert player' do
        message = 'this column is full. Try another column'
        expect(game).to_not receive(:puts).with(message)
        game.get_input
      end
    end
  end

  describe '#make_move' do
    before do
      input = '6'
      allow(game).to receive(:gets).and_return(input)
      allow(game).to receive(:print)
      allow(game).to receive(:puts)
    end
    it 'sends #drop to Board' do
      expect(board).to receive(:drop)
      game.make_move
    end
  end
end
