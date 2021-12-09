require_relative "board"
require_relative "player"
require 'byebug'

class Battleship
   attr_reader :board, :player
   
   def initialize(n)
      @player = Player.new
      @board = Board.new(n)
      @remaining_misses = (n * n) / 2
   end

   def start_game
      # debugger
      @board.place_random_ships
      puts "Number of Ships Left: #{@board.num_ships}"
      @board.print
   end

   def lose?
      if @remaining_misses <= 0
         print 'you lose'
         return true
      end
      false
   end
   
   def win?
      if @board.num_ships <= 0
         print 'you win'
         return true
      end
      false
   end

   def game_over?
      if win? || lose?
         return true
      end
      false
   end

   def turn
      pos = @player.get_move
      if !@board.attack(pos)
         @board.print
         @remaining_misses -= 1
         puts "Number of Ships Left: #{@board.num_ships}"
         puts "Remaining Misses: #{@remaining_misses}"
      else
         @board.print
      end
   end
end
