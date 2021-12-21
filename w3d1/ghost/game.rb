require_relative 'player'
require 'set'
require 'byebug'


# Instantiate a new Game object, passing in both of the Players.
    # The Game maintains a fragment instance variable, which represents the word as it has been built up by the players.

    # The Players take turns adding a letter to the fragment. The Game should ensure that a play is valid before actually changing the fragment.
    
    # The Game checks the fragment against a dictionary; if the fragment is a word contained in the dictionary, then the previous player loses.

    
class Game

    ABC = Set.new("a".."z")
    attr_reader :players, :fragment, :dictionary, :losses
    attr_writer :fragment

    def initialize(*players)
        @players = players
        @fragment = ""
        @losses = Hash.new { |losses, player| losses[player] = 0 }
        words = File.open("dictionary.txt").read.split
        @dictionary ||= Set.new(words)
    end

    def current_player # array
        players.first
    end

    def previous_player
        players.last
    end

    def next_player!
        players.rotate!
    end

    def take_turn(player)
        system("clear")
        puts "#{current_player.name}, enter a letter!"
        
        guess = false
        while guess == false
            guess = current_player.guess(@fragment)
            if !valid_play?(guess)
                current_player.alert_invalid_guess(guess)
                guess = false
            end
        end
        fragment << guess
        puts "#{current_player.name} put '#{guess}' into the fragment"
        sleep(1)
    end

    def valid_play?(string)
        return false if !ABC.include?(string)
        possible_word = @fragment + string
        dictionary.any? { |word| word.start_with?(possible_word) }
    end

    def record(player)
        ghost = "GHOST"
        games_lost = losses[player]
        ghost[0...games_lost]
    end

    def play_round
        @fragment = ""
        sleep(1)
        system("clear")
        display_standings
        until lose_round?
            take_turn(current_player)
            next_player!
        end
    end

    def display_standings
        puts "Current Standings: \n\n"
        players.each do |player|
            puts "#{player.name}: #{record(player)}"
        end
        sleep(1)
    end 

    def run
        system("clear")
        puts "Ghost"
        puts "Players must take turns putting a letter into the fragment"
        puts "If a player finishes a word, they lose a round"
        puts "When a player reaches 5 losses, the game is over"
        puts "Press Enter to play"
        enter = gets.chomp
        if enter == ""
            play_round until lose_game?
            puts "#{current_player.name} loses!"
        else
            run
        end
    end

    def lose_game?
        losses.values.any? { |val| val == 5 }
    end

    def lose_round?
        if @dictionary.include?(@fragment)
            puts "#{@fragment} is a word in the dictionary, #{previous_player.name} loses a round"
            losses[previous_player] += 1
        end
    end


    private
    
end

if $PROGRAM_NAME == __FILE__
    game = Game.new(
    Player.new("George"),
    Player.new("Nemo")
    )
    game.run
end