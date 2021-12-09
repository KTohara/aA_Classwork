require 'byebug'
class Board
	attr_reader :size

	def self.print_grid(grid)
		grid.each do |row|
			puts row.join(" ")				# puts adds \n automatically
			# print row.join(" "),"\n"		# print needs obj,"\n"
		end
	end

	def initialize(n)
		@grid = Array.new(n) { [:N] * n }
		@size = n * n
	end

	def [](pos_index)
		i = pos_index[0]
		j = pos_index[1]
		
		@grid[i][j]
	end

	def []=(pos_index, val)
		i = pos_index[0]
		j = pos_index[1]
		@grid[i][j] = val
	end

	def num_ships
		count = 0
		@grid.each do |sub|
			sub.each do |symbol|
				count += 1 if symbol == :S
			end
		end
		count
	end

	def attack(pos)
		if self[pos] == :S
			self[pos] = :H 
			p 'You sunk my battleship!!'
			return true
		end
		self[pos] = :X
		false
	end

	def place_random_ships
		ships = @size * 0.25

		while num_ships < ships
			row = rand(@grid.length)
			col = rand(@grid.length)
			pos = [row, col]
			self[pos] = :S
		end
		# ships.to_i.times do		# DOES NOT WORK - it will place n times, but some ships may overwrite others
		# 	count += 1
		# 	self[[row, col]] = :S
		# end
	end
	# debugger

	def hidden_ships_grid
		hidden = @grid.map do |row|
			row.map do |space|
				space == :S ? :N : space
			end
		end
		hidden
	end
	
	def cheat
		Board.print_grid(@grid)
	end

	def print
		Board.print_grid(self.hidden_ships_grid)
	end
end