class Game
    def initialize
        @code_breaker = Player.new(self)
        @guesses = []
        @code = @code_breaker.create_code
        @turn_number = 1
    end

    def play
        puts "Welcome to MasterMind!"
        puts "The code is #{@code}"
        loop do
            puts "\n\nTurn #{@turn_number}/12"
            print_board
            guess = @code_breaker.guess
            @guesses.push(guess)
            clue = check_guess(guess)
            if check_win(clue)
                puts "\nThe code breaker won! The code was #{@code}"
                return
            end
            if @turn_number == 12
                puts "\nThe code maker won! The code was #{@code}"
            end
            @turn_number += 1
        end
    end

    def print_board
        puts
        @guesses.each {|guess| puts "#{guess} | #{check_guess(guess)}"}
        puts
    end

    def check_guess(guess)
        left_to_guess = @code.clone
        left_to_check = guess.clone
        clue = ""
        left_to_check.each_char.with_index do |x, index|
            if left_to_guess[index] == x
                clue += "*"
                left_to_guess[index] = "-"
                left_to_check[index] = "-"
                p left_to_guess
            end
        end
        left_to_check.each_char.with_index do |x, index|
            unless x == "-"
                if left_to_guess.include? x
                    clue += "?"
                    left_to_guess.sub!(x, "-")
                    left_to_check[index] = "-"
                    p left_to_guess
                end
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

Game.new.play