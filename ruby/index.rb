require "colorize"
require_relative "./class/Board.rb"
require_relative "./class/Game.rb"
require_relative "./class/Renderer.rb"

def parse_move raw
  raise ArgumentError if raw.size > 2 or raw.size < 2 
  raw_x, raw_y = raw.split ""
  raise ArgumentError if not raw_x =~ /[[:alpha:]]/ or not raw_y.to_i.between?(0, 3)

  {
    :x => ["a", "b", "c"].find_index { |itm| itm == raw_x.downcase },
    :y => raw_y.to_i - 1
  }
end

def get_move
  x = nil
  y = nil
  while x == nil and y == nil
    begin
      parsed = parse_move gets.chomp
      x = parsed[:x]
      y = parsed[:y]
    rescue ArgumentError
      puts "valid moves are in the form number then letter, e.g. a1 or b2."
    end
  end
  { :x => x, :y => y}
end

def main
  @board = Board.new
  @game = Game.new :board => @board
  @renderer = Renderer.new :game => @game, :board => @board

  won = false
  moves = 0
  x = -1
  y = -1
  begin
  while not won
    @renderer.render
    puts "\n\n"
    puts "#{@game.current_player}'s move"
    puts "\n"
    puts "where would you like to move? (letter then number, e.g. #{"a1".yellow})"

    # wait for a valid move?
    while not @board.can_move x, y
      puts "you can't move there -- someone already did! try again."
      x, y = get_move.values_at :x, :y
    end

    @game.move x, y, @game.current_player
    moves += 1

    if @game.win? x, y
      won = true
      @renderer.render
      puts "\n\n"
      puts "congratulations #{@game.change_player.red}!"
    end
    
    if moves == 9
      won = true
      @renderer.render
      puts "\n\n"
      puts "looks like nobody won this one. #{":(".blue}"
    end
  end

  rescue Interrupt
    # no-op
  end
end

main

