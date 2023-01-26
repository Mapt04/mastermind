class Game
    def initialize
        @code_breaker = Player.new(self)
        @guesses = []
        @code = @code_breaker.create_code
    end

    def print_board
        @guesses.each {|guess| puts guess}
    end

    def check_guess(guess)
        left_to_guess = @code
        clue = ""
        guess.each_char.with_index do |x, index|
            p left_to_guess[index]
            if left_to_guess[index] == x
                clue += "*"
                left_to_guess[index] = "-"
            end
        end
        guess.each_char do |x|
            if left_to_guess.include? x
                clue += "?"
                left_to_guess.sub!(x, "-")
            end
        end
        left_to_guess.each_char do |x|
            unless x == "-"
                clue += "-"
            end
        end
        clue
    end

    def check_win(clue)
        clue == "****"
    end
end

class Player
    def initialize(game)
        @game = game
    end

    def create_code
        code = ""
        4.times {code += rand(1..6).to_s}
        code
    end

    def guess
        loop do
            print "Make a guess: "
            guess = gets.chomp
            return guess if guess.length == 4 && guess.chars.all? {|x| x.to_i in 1..9}
            puts "Invalid Guess"
        end
    end
end