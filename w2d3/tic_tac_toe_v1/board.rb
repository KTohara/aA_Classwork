require 'byebug'

class Board
   def initialize
      @grid = Array.new(3) { ['_'] * 3 }
   end

   def [](pos)
      row, col = pos
      @grid[row][col]
   end

   def []=(pos, val)
      row, col = pos
      @grid[row][col] = val
   end

   def valid?(pos) # ie [1, 4]
      i = pos[0]
      j = pos[1]
      @grid[i][j] != nil
      # pos.all? do |i|
      #    0 <= i && i < @grid.length
      # end
   end

   def empty?(pos)
      self[pos] == '_'
   end

   def place_mark(pos, mark)
      raise "#{pos} is not a valid spot!" if !valid?(pos) || !empty?(pos)
      self[pos] = mark
   end

   def printboard
      @grid.each { |row| puts row.join(" ") }
   end

   def win_row?(mark)
      # @grid.any? do |row|
      #    if row.count(mark) == @grid[0].length
      #       puts "Player with #{mark} wins!"
      #       return true
      #    end
      #    false
      # end
      @grid.any? do |row|
         row.all? { |el| el == mark }
      end
   end

   def win_col?(mark)   
      # new_grid = @grid.transpose
      # new_grid.each do |row|
      #    if row.count(mark) == @grid[0].length
      #       puts "Player with #{mark} wins!"
      #       return true
      #    end
      #    false
      # end

      @grid.transpose.any? do |col|
         col.all? { |el| el == mark }
      end
   end

   def win_diagonal?(mark)
      # win diagonal one way
      count = 0
      @grid.each_index do |i|
         @grid[0].each_index do |j|
            pos = [i, j]
            count += 1 if self[pos] == mark
         end
      end
      if count == @grid.length
         return true
      end

      # win diagonal other way
      transpose_count = 0
      new_grid = @grid.transpose
      @new_grid.each_index do |i|
         @new_grid[0].each_index do |j|
            pos = [i, j]
            transpose_count += 1 if self[pos] == mark
         end
      end
      if transpose_count == @grid.length
         return true
      end
   end

   def win?(mark)
      win_diagonal?(mark) || win_row?(mark) || win_col?(mark)
   end

   def fill_all
      (0...@grid.length).each do |i|
         (0...@grid.length).each do |j|
            @grid[i][j] = :O
         end
      end
   end

   def has_empty_positions?
      (0...@grid.length).any? do |i|
         (0...@grid.length).any? do |j|
            pos = [i, j]
            empty?(pos)
         end
      end

      # count = 0
      # @grid.each do |row|
      #    row.each { |el| count += 1 if el == "_" }
      # end
      # count == 0 ? true : false
   end
end

# Pry.toplevel_binding.eval File.read("board.rb")
game = Board.new
# p game.empty?([1,2])
# diagonal
game.place_mark([0,0], :O)
game.place_mark([1,1], :O)
game.place_mark([2,2], :O)
# diagonal
# game.place_mark([0,2], :O)
# game.place_mark([1,1], :O)
# game.place_mark([2,0], :O)
# col
# game.place_mark([0,0], :O)
# game.place_mark([1,0], :O)
# game.place_mark([2,0], :O)
# row
# game.place_mark([0,0], :O)
# game.place_mark([0,1], :O)
# game.place_mark([0,2], :O)
# game.place_mark([1,4], ":X")
# print game.grid[0], "\n", game.grid[1], "\n", game.grid[2], "\n"
# game.printboard
# game.win_row?(:O)
# game.win_col?(:O)
# p game.win_diagonal?(:O)
# game.win?(:O)
p game.has_empty_positions?
# game.printboard