class Game
    def initialize
        @guesses = []
        @clues = []
        @turn_number = 1
    end
    attr_reader :turn_number

    def play
        puts "Welcome to MasterMind!"
        choose_mode
        @code = @code_breaker.create_code
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
                return
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
            end
        end
        left_to_check.each_char.with_index do |x, index|
            unless x == "-"
                if left_to_guess.include? x
                    clue += "?"
                    left_to_guess.sub!(x, "-")
                    left_to_check[index] = "-"
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

    def choose_mode
        loop do
            print "Do you want to be the code-setter (1) or the code-breaker (2): "
            response = gets.chomp
            if response == "1"
                @code_breaker = ComputerPlayer.new(self)
                return
            end
            if response == "2"
                @code_breaker = Player.new(self)
                return
            end
            puts "Invalid response"
        end
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

class ComputerPlayer < Player
    def create_code
        loop do
            print "Create a code: "
            code = gets.chomp
            return code if code.length == 4 && code.chars.all? {|x| x.to_i in 1..9}
            puts "Invalid guess"
        end
        code
    end

    def guess
        guess = ""
        4.times {guess += rand(1..6).to_s}
        guess
    end
end
Game.new.play