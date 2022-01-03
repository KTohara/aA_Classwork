require 'byebug'

class Hangman
   DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

   def self.random_word
      DICTIONARY.sample
   end

   def initialize
      @secret_word = Hangman.random_word
      @guess_word = Array.new(@secret_word.length, "_")
      @attempted_chars = []
      @remaining_incorrect_guesses = 5
   end

   def guess_word
      @guess_word
   end
   def attempted_chars
      @attempted_chars
   end
   def remaining_incorrect_guesses
      @remaining_incorrect_guesses
   end

   def already_attempted?(char)
      if attempted_chars.include?(char)
         return true
      end
      false
   end

   def get_matching_indices(char)
      match_indices = []
      @secret_word.each_char.with_index { |secret_char, i| match_indices << i if secret_char == char }
      match_indices
   end

   def fill_indices(char, indices)
      # @guess_word.map!.with_index { |char, i| indices.include?(i) ? @secret_word[i] : char }
      indices.each { |i| @guess_word[i] = char }
   end

   def try_guess(char)
      if already_attempted?(char)
         puts 'that has already been attempted'
         return false
      end
      attempted_chars << char
      
      matches = get_matching_indices(char)
      if matches.empty?
         @remaining_incorrect_guesses -= 1
      end
      
      indices = get_matching_indices(char)
      fill_indices(char, indices)
      true
   end

   def ask_user_for_guess
      puts 'Enter a char:'
      guess = gets.chomp
      try_guess(guess)
   end

   def win? 
      if @guess_word.join == @secret_word
         puts 'WIN'
         return true
      end
      false
   end

   def lose?
      if @remaining_incorrect_guesses == 0
         puts 'LOSE'
         return true
      end
      false
   end

   def game_over?
      if win? || lose?
         puts @secret_word
         return true
      end
      false
   end
end
