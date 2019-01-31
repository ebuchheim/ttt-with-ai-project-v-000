module Players
    class Computer < Player

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

        def move(board)
            corners_array = corners(board)
            best_rest_array = other_avail_moves(board)
            if middle?(board)
                return "5"
            elsif move_to_win(board)
                return move_to_win(board) + 1
            elsif move_to_block(board)
                return move_to_block(board) + 1
            elsif get_best_corner(corners_array, board)
                return get_best_corner(corners_array, board)
            elsif get_best_rest(best_rest_array, board)
                return get_best_rest(best_rest_array, board)
            elsif corners_array != nil
                corners_array.sample
            elsif best_rest_array != nil
                best_rest_array.sample
            end
        end

    def middle?(board)
        board.valid_move?(5)
    end

    def corners(board)
        corners_array = []
        board.cells.each_with_index do |space, index|
            move = index + 1
            if move.odd? && board.valid_move?(move)
                corners_array << move
            end
        end
        corners_array
    end

    def other_avail_moves(board)   #this gets the side middles (moves 2, 4, 6, & 8)
        avail_moves = []
        board.cells.each_with_index do |space, index|
            move = index + 1
            if move.even? && board.valid_move?(move)
                avail_moves << move
            end
        end
        avail_moves
    end

    def get_best_rest(moves, board)    #checks side middles when no corner with 1+ complement token
        best_rest = []
        moves.map do |move|
            WIN_COMBINATIONS.map do |win_combo|
                contents = win_combo.map {|i| board.cells[i]}
                if win_combo.include?(move - 1) && contents.include?(self.token)
                    best_rest << move
                end
            end
        end
        best_rest.sample
    end

    def get_best_corner(corners, board)
        best_corners = []
        corners.map do |corner|
            WIN_COMBINATIONS.map do |win_combo|
                contents = win_combo.map {|i| board.cells[i]}
                if win_combo.include?(corner - 1) && contents.include?(self.token)
                    best_corners << corner
                end
            end
        end
        best_corners.sample
    end

    def move_to_block(board)
        WIN_COMBINATIONS.each do |win_combo|
            contents = win_combo.map {|i| board.cells[i]}
            opponent = get_opponent_token
            if contents.count(opponent) == 2 && contents.count(self.token) == 0
                blocker = contents.find_index(" ")
                return win_combo[blocker]
            end
        end
        return nil
    end

    def move_to_win(board)
        WIN_COMBINATIONS.each do |win_combo|
            contents = win_combo.map {|i| board.cells[i]}
            opponent = get_opponent_token
            if contents.count(self.token) == 2 && contents.count(opponent) == 0
                winner = contents.find_index(" ")
                return win_combo[winner]
            end
        end
        return nil
    end

    def get_opponent_token
        self.token == "X" ? "O" : "X"
    end


    end
    #end of class
    
    

  end