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

  before do
    allow(game).to receive(:system)
  end

  describe '#assign_symbol' do
    context 'for player1' do
      it "sends #set_symbol to player1" do
        desired_symbol = "\e[31m\u25CF\e[0m"
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
    before do
      name = 'Player1'
      allow(game).to receive(:gets).and_return(name)
      allow(game).to receive(:puts)
      allow(game).to receive(:print)
    end

    context 'for player 1' do
      it "sends #set_name to player1" do
        desired_name = 'Player1'
        expect(player1).to receive(:set_name).with(desired_name)
        game.assign_names
      end
    end

    context 'for player 2' do
      before do
        name = 'Player2'
        allow(game).to receive(:gets).and_return(name)
      end

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

  describe '#valid_move?' do
    context 'when column number is valid and not full' do
      before do
        allow(board).to receive(:column_valid?).and_return(true)
        allow(board).to receive(:column_full?).and_return(false)
      end

      it 'returns true' do
        column_no = 5
        result = game.valid_move?(column_no)
        expect(result).to be(true)
      end
    end

    context 'when column number is valid but full' do
      before do
        allow(board).to receive(:column_valid?).and_return(true)
        allow(board).to receive(:column_full?).and_return(true)
      end

      it 'returns false' do
        column_no = 5
        result = game.valid_move?(column_no)
        expect(result).to be(false)
      end
    end

    context 'when column number is invalid' do
      before do
        allow(board).to receive(:column_valid?).and_return(false)
        allow(board).to receive(:column_full?).and_return(true)
      end

      it 'returns false' do
        column_no = 5
        result = game.valid_move?(column_no)
        expect(result).to be(false)
      end
    end
  end

  describe '#display_error_message' do
    context 'when column number is invalid' do
      it 'displays invalid column message' do
        message = "\e[31menter a valid column number between 1 and 7\e[0m"
        column_no = 8
        expect(game).to receive(:puts).with(message)
        game.display_error_message(column_no)
      end
    end

    context 'when column is full' do
      before do
        allow(board).to receive(:column_full?).and_return(true)
      end

      it 'displays column full message' do
        message = "\e[93mthis column is full. Try another column\e[0m"
        column_no = 3
        expect(game).to receive(:puts).with(message)
        game.display_error_message(column_no)
      end
    end
  end
end
