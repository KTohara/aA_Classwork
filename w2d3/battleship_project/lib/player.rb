class Player
   def get_move # returns an arr with 2 pos ie: [1, 4]
      print 'enter a position with coordinates separated with a space like `4 7`:'
      guess = gets.chomp
      guess.split.map { |char| char.to_i }
   end
end
