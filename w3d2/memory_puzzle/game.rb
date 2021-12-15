require_relative "board.rb"
require_relative "card.rb"
require "byebug"

class Game
	# VARIABLES:
		# board: should initialize a new board
		# prev_guess: previously-guessed position (if any)

	# METHODS:
		# prompt: should ask for a player's guess using gets.chomp.to_i
		# make_guess: Board.guess_pos 
		# game_over: when the game is over
		
		# play: loops the game, until over
			# @board.render the current board
			# prompt the user for make_guess #1
				# reveal card with make_guess
			# prompt the user for make_guess #2
				# reveal card with make_guess
			# if both guesses == Card.face_value...
				# "its a match!"
			# else
				# "try again"
			# if Board.won?
				# game_over

	attr_reader :board

	def initialize(size, prev_guess=nil)
		@board = Board.new(size)
		@prev_guess = prev_guess
	end

	def prompt
		while true
			puts "Enter a position: IE 3 5"
			guess = gets.chomp.split.map(&:to_i)
			
			if !@board[guess].is_a?(Card)
				puts "Invalid position - position is out of bounds"
			elsif @board[guess].visible?
				puts "Invalid position - card is already revealed"
			else
				puts
				return guess
			end
		end
	end





# play: loops the game, until over
	# @board.render the current board
	# prompt the user for make_guess #1
		# reveal card with make_guess
	# prompt the user for make_guess #2
		# reveal card with make_guess
	# if both guesses == Card.face_value...
		# "its a match!"
	# else
		# "try again"
	# if Board.won?
		# game_over
	def play
		
		while !@board.won?
			
			@board.render
			puts "enter first guess:"
			guess_1_pos = self.prompt
			card_value_1 = @board.reveal_on_board(guess_1_pos)
			@board.render
			puts "enter second guess:"
			guess_2_pos = self.prompt
			card_value_2 = @board.reveal_on_board(guess_2_pos)
			if card_value_1 == card_value_2
				puts "its a match"
			else
				@board[guess_1_pos].hide
				@board[guess_2_pos].hide
				puts "try again"
			end
		end
		puts "Congrats, you WON!"
	end
end

b = Game.new(2)
b.play