require "colorize"

class Renderer
  def initialize kwargs
    @game = kwargs[:game]
    @board = kwargs[:board]
  end

  def lift itm
    itm ? itm : " "
  end

  def render
    system "clear" or system "cls"
    
    top = "   A   B   C \n".green

    board = @board.board.map.with_index { |row, idx|
      r = row.map { |itm| self.lift(itm) }
      (idx + 1).to_s.green + "  " + r.join(" | ") + " "
    }.join "\n  ---+---+---\n"

    puts "\n" + top + board
  end
end
