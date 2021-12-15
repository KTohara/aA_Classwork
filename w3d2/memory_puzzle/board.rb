require_relative "card.rb"
require "byebug"
class Board
# VARIABLES:
	# creating a board:
		# what size should it be?
		# what should it be filled with?

# METHODS:
	# populate:
		# should fill the board with PAIRS of Card.new - hidden
	# render:
		# HUD to display board's current state
	# won?:
		# return true if all cards are Card.reveal'ed
	# guessed_pos:	
		# should take a position
		# reveal the pos if is_visible = false
		# return the face_value of the card
	
	# reveal:
		# if the card is not_visible... 
			# should Card.reveal at a position
			# should turn the pos of card to show face_value
	
	def initialize(n)
		raise "Invalid size: size must be an even number" if n.odd?
		@size = n
		@grid = Array.new(n) { Array.new(n, "") }
		self.populate
	end

	# def populate
	# 	total_pairs = (@size ** 2) / 2 # 8
	# 	current_pairs = 0
	
	# 	while current_pairs < total_pairs
	# 		face_value = ("A".."Z").to_a.sample
	# 		card_1 = Card.new(face_value)
	# 		card_2 = Card.new(face_value)
		
	# 		pos_1 = [rand(0...@size), rand(0...@size)]
	# 		pos_2 = [rand(0...@size), rand(0...@size)]
			
	# 		if self[pos_1].is_a?(String) && self[pos_2].is_a?(String)
	# 			debugger
	# 			self[pos_1] = card_1
	# 			self[pos_2] = card_2
	# 			current_pairs +=1
	# 		end
	# 	end
	# end
	def populate
		#debugger
		num_pairs = (@size**2) / 2
		cards = Card.shuffled_pairs(num_pairs)
		@grid.each_index do |i|
		  @grid[i].each_index do |j|
			self[[i, j]] = cards.pop
		  end
		end
	  end


	def [](pos)
		row,col = pos 
		@grid[row][col]
	end

	def []=(pos,value)
		row,col = pos 
		@grid[row][col] = value
	end

	def render
		@grid.each do |row|
			row.each do |ele|
				if ele.visible?
					print ele.face_value + " "
				else
					print "_ "
				end
			end
			puts
		end
	end

	def set_all_visible
		@grid.each do |row|
			row.each do |ele|
				ele.reveal
			end 
		end
	end

	def won? # returns true or false
		@grid.all? do |row|
			row.all? do |ele|
				ele.visible?
			end
		end
	end

	# should take a position
	# reveal the pos if is_visible = false
	# return the face_value of the card
	def reveal_on_board(pos)
		if !self[pos].visible?
			self[pos].reveal
			return self[pos].face_value
		end
	end

end


