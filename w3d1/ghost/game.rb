require_relative 'player'
require 'set'
require 'byebug'

class Game

    ABC = Set.new("a".."z")

    def initialize(*players)
        @players = players
        @fragment = ""
        @losses = Hash.new { |losses, player| losses[player] = 0 }
        players.each { |player| losses[player] = 0 }
        words = File.open("dictionary.txt").read.split
        @dictionary ||= Set.new(words)
    end

    # Helper Methods

    def current_player
        players.first
    end

    def previous_player
        players.reverse.each do |player|
            return player if !player_lost?(player)
        end
    end

    def next_player!
        players.rotate!
        until !player_lost?(current_player)
            players.rotate!
        end
    end

    def player_lost?(player)
        losses[player] >= 5
    end

    def valid_play?(string)
        return false if !ABC.include?(string)
        possible_word = @fragment + string
        dictionary.any? { |word| word.start_with?(possible_word) }
    end

    def remaining_players
        players.reject { |player| player_lost?(player) }
    end 

    def win_game?
        remaining_players.count == 1
    end

    # UI Methods

    def record(player)
        ghost = "G H O S T"
        games_lost = losses[player]
        ghost[0...games_lost * 2]
    end

    def display_standings
        puts "Current Standings: \n\n"
        players.each do |player|
            puts "#{player.name}: #{record(player)}"
        end
        sleep(1)
    end

    # Game Mechanic Methods

    def run
        system("clear")
        puts "Ghost"
        puts "Players must take turns putting a letter into the fragment"
        puts "If a player finishes a word, they lose a round"
        puts "When a player reaches 5 losses, the game is over"
        puts "Press Enter to play"
        enter = gets.chomp
        if enter == ""
            play_round until win_game?
            puts "#{current_player.name} wins!"
        else
            run
        end
    end

    def play_round
        @fragment = ""
        system("clear")
        display_standings
        sleep(2)
        until lose_round?
            take_turn(current_player)
            next_player!
        end
    end

    def lose_round?
        if @dictionary.include?(@fragment)
            puts "#{@fragment} is a word in the dictionary, #{previous_player.name} loses a round"
            sleep(2)
            player_eliminated?
        end
    end

    def player_eliminated?
        if losses[previous_player] == 4
            puts "#{previous_player.name} has reached 'G H O S T'"
            puts "#{previous_player.name} has been eliminated :("
            sleep(2)
        end
        losses[previous_player] += 1

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
    private
    attr_reader :players, :fragment, :dictionary, :losses
end

if $PROGRAM_NAME == __FILE__
    game = Game.new(
    Player.new("George"),
    Player.new("Lenny"),
    Player.new("Rabbit")
    )
    game.run
end