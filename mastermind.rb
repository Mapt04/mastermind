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
        guess.each_with_index do |x, index|
            if left_to_guess[index] == x
                clue += "*"
                left_to_guess[index] = "-"
            end
        end
        guess.each do |x|
            if left_to_guess.includes? x
                clue += "?"
                left_to_guess.index(x) = "-"
            end
        end
        guess.each do |x|
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
        code = []
        4.times do {code.push rand(1..6)}
        code
    end

    def guess
        loop do
            print "Make a guess: "
            guess = gets.chomp
            return guess if guess.length == 4 and guess.all? {|x| x.to_i in 1..9}
            puts "Invalid Guess"
        end
    end
end