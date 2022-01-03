require_relative './board.rb'
require_relative './human_player.rb'


class Game
   
   def initialize(mark_1, mark_2)
      @player_1 = HumanPlayer.new(mark_1)
      @player_2 = HumanPlayer.new(mark_2)
      @current_player = @player_1
      @board = Board.new
   end

   def switch_turn
      if @current_player == @player_1
         @current_player = @player_2
      else
         @current_player = @player_1
      end
   end

   def play
      while @board.has_empty_positions?
         @board.printboard
         pos = @current_player.get_position
         mark = @current_player.mark
         @board.place_mark(pos, mark)
         if @board.win?(mark)
            puts "GAME OVER!"
            puts "#{@current_player} with #{mark} wins!"
            return
         else
            switch_turn
         end
      end
      puts "DRAW GAME!"
   end
end