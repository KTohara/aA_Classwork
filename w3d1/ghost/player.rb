class Player
    attr_reader :name

    def initialize(name)
        @name = name
    end

    def guess(fragment)
        puts "The current fragment is '#{fragment}'"
        gets.chomp.downcase
    end

    def alert_invalid_guess(guess)
        puts "#{guess} is not a valid guess\n\n"
        puts "The letter must be a part of the alphebet"
        puts "When you enter a letter into the fragment, it must form a potential word\n\n"
    end
end