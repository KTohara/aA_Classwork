require_relative "code"

class Mastermind
   def initialize(len)
      @secret_code = Code.random(len)
   end

   def print_matches(guess_inst)
      p @secret_code.num_exact_matches(guess_inst)
      p @secret_code.num_near_matches(guess_inst)
   end

   def ask_user_for_guess
      p 'Enter a code: '
      guess = gets.chomp
      guess_instance = Code.from_string(guess)
      p @secret_code.num_exact_matches(guess_instance)
      p @secret_code.num_near_matches(guess_instance)
      @secret_code == guess_instance
   end
end
