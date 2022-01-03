class Card

	VALUES = ("A".."Z").to_a

  	def self.shuffled_pairs(num_pairs)
		values = VALUES

		while num_pairs > values.length
			values = values + values
		end

		values = values.shuffle.take(num_pairs) * 2
		values.shuffle!
		values.map { |val| self.new(val) }
  	end
	attr_reader :face_value, :face_up

	def initialize(face_value)
		@face_value = face_value
		@is_visible = false
	end

	def visible?
		@is_visible
	end

	def hide
		@is_visible = false
	end

	def reveal
		@is_visible = true
	end

	def ==(other_card)
		self.face_value == other_card.face_value
	end

	def to_s
		if @is_visible == true
			self.face_value
		else
			" "
		end
	end
end