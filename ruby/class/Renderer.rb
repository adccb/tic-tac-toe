require "colorize"

class Renderer
  def initialize kwargs
    @game = kwargs[:game]
    @board = kwargs[:board]
  end

  def render
    system "clear" or system "cls"

    lift = Proc.new { |itm| itm ? itm : " " }
    format_row = Proc.new do |row, idx|
      r = row.map &lift
      "#{(idx + 1).to_s.green}  #{r.join(" | ")} "
    end

    top = "   A   B   C \n".green
    board = @board.board
      .map.with_index(&format_row)
      .join "\n  ---+---+---\n"

    puts "\n#{top + board}"
  end
end
