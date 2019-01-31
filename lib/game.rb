class Game

    attr_accessor :board, :player_1, :player_2

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        @board = board
        @player_1 = player_1
        @player_2 = player_2
    end

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
      ]

    def board
        @board
    end

    def player_1
        @player_1
    end

    def player_2
        @player_2
    end

    def current_player
        @board.turn_count.even? ? player_1 : player_2
    end

    def won?
        WIN_COMBINATIONS.each do |individual_combo|  
            win_index_1 = individual_combo[0]
            win_index_2 = individual_combo[1]
            win_index_3 = individual_combo[2]
      
            position_1 = @board.cells[win_index_1]
            position_2 = @board.cells[win_index_2]
            position_3 = @board.cells[win_index_3]
      
            if position_1 == "X" && position_2 == "X" && position_3 == "X"
              return individual_combo
            elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
              return individual_combo
            end
        end
        false
    end

    def draw?
        !won? && @board.full?
    end

    def over?
        won? || draw?
    end

    def winner
        if won?
            winning_index = won?[0]
            @board.cells[winning_index]
        end
    end

    def turn 
        @board.display
        puts "It's your turn, #{current_player.token}!"
        user_input = current_player.move(@board)
        if @board.valid_move?(user_input)
            @board.update(user_input, current_player)
        else
            puts "Sorry, that spot is already taken!"
            turn
        end
    end

    def play
        puts "Welcome to Tic Tac Toe!"
        counter = 0
        until counter == 9 || over?
          turn
          counter += 1
        end
        if won?
            @board.display
            puts "Congratulations #{winner}!"
        elsif draw?
            @board.display
            puts "Cat's Game!"
        end
    end

    def self.start
        game = Game.new(Players::Human.new("X"), Players::Computer.new("O"))
        game.play
    end

    def self.start_two_humans
        game = Game.new(Players::Human.new("X"), Players::Human.new("O"))
        game.play
    end

    def self.start_wargames
        x_won = 0
        o_won = 0
        tie_game = 0
        game = Game.new(Players::Computer.new("X"), Players::Computer.new("O"))
        100.times do
            game.play
            if game.winner == "X"
                x_won += 1
            elsif game.winner == "O"
                o_won += 1
            else
                tie_game += 1
            end
        end
        puts "Computer played Computer 100 times.  Whew!"
        puts "Here are the standings:"
        puts "X won the game #{x_won} times."
        puts "O won the game #{o_won} times."
        puts "And X tied O #{tie_game} times."
    end
end
