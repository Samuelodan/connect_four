#frozen_string_literal: true

class Player
  attr_reader :symbol

  def initialize
    @symbol = nil 
  end

  def set_symbol(sym)
    @symbol = sym
  end
end
