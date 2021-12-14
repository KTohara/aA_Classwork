class Code
	POSSIBLE_PEGS = {
		"R" => :red,
		"G" => :green,
		"B" => :blue,
		"Y" => :yellow
	}

	attr_reader :pegs

	def self.valid_pegs?(peg_arr)	# array
		peg_arr.all? { |char| (POSSIBLE_PEGS.keys).include?(char.upcase) }
	end

	def self.random(len)
		peg_arr = []
		while peg_arr.length < len
			peg_arr << POSSIBLE_PEGS.keys.sample
		end
		Code.new(peg_arr)
	end

	def self.from_string(peg_string)
		peg_arr = peg_string.split("")
		Code.new(peg_arr)
	end

	def initialize(peg_arr)
		if Code.valid_pegs?(peg_arr)
			@pegs = peg_arr.map(&:upcase)
		else
			raise "not valid pegs"
		end
	end

	def [](idx)
		@pegs[idx]
	end

	def length
		@pegs.length
	end

	def num_exact_matches(guess_instance)
		guess = guess_instance.pegs
		length = guess.length

		(0...length).count { |i| guess[i] == self[i] }
	end

	def num_near_matches(guess_instance)
		guess_dup = guess_instance.pegs.dup
		secret_dup = self.pegs.dup

		(0...guess_dup.length).each do |i|
			if guess_dup[i] == secret_dup[i]
				guess_dup[i] = "@"
				secret_dup[i] = "@"
			end
		end

		guess_dup.delete("@")
		secret_dup.delete("@")

		# puts "#{secret_dup}" + "self_dup"
		# puts "#{code_instance.pegs}" + "guess"
		# puts "#{guess_dup}" + "guess_dup"
		# puts
		count = 0
		guess_dup.each.with_index do |peg, i|
			if secret_dup.include?(peg)
				count += 1
				secret_dup.delete_at(secret_dup.index(peg))
			end
		end
		count
	end

	def ==(code_instance)
		code_instance.pegs == self.pegs
	end

end
