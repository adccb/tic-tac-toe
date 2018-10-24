require_relative "./class/Board.rb"
require_relative "./class/Game.rb"
require_relative "./class/Renderer.rb"

def parse_move raw
  raise ArgumentError if raw.size > 2 or raw.size < 2 
  raw_x, raw_y = raw.split ""
  raise ArgumentError if not raw_x =~ /[[:alpha:]]/ or not raw_y.to_i.between?(0, 4)

  {
    :x => ["a", "b", "c"].find_index { |itm| itm == raw_x.downcase },
    :y => raw_y.to_i - 1
  }
end

def main
  @board = Board.new
  @game = Game.new :board => @board
  @renderer = Renderer.new :game => @game, :board => @board

  won = false
  while not won
    @renderer.render
    puts "\n\n"
    puts "#{@game.current_player}'s move"
    puts "\n"
    puts "where would you like to move? (e.g. a1)"
    x, y = parse_move(gets.chomp).values_at :x, :y
    @game.move x, y, @game.current_player

    if @game.win? x, y
      won = true
      @renderer.render
      puts "\n\n"
      puts "congratulations #{@game.change_player}!"
    end
  end
end

main

