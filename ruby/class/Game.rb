require_relative "./Board.rb"

class Game
  def initialize(kwargs)
    @board = kwargs[:board]
    @players = [ "x", "o" ]
    @current_player = @players[0]
  end

  def current_player() @current_player end

  def change_player
    idx = @players.find_index { |itm| itm == @current_player }
    @current_player = @players[idx - 1]
  end

  def win? x, y
    [
      @board.get_row(y), 
      @board.get_col(x), 
      @board.get_diag(:up), 
      @board.get_diag(:down)
    ].any? do |moves| 
      moves.all? { |move| not move.nil? and move == moves[0] } 
    end
  end

  def move x, y, v
    @board.set x, y, v
    self.win? x, y
    self.change_player
  end
end
