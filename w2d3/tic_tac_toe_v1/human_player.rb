class HumanPlayer

   attr_reader :mark
   
   def initialize(val)
      @mark = val
   end

   def get_position
      puts "Enter a position with the format: 'row col'"
      guess = gets.chomp.split
      if guess.length != 2 || guess.map.any? { |x| ("a".."z").include?(x) }
         raise "Follow the format 'row col' IE: 0 2"
      end
      guess.map(&:to_i)
   end
end