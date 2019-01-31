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
            if middle?(board)
                return "5"
            elsif corners?(board) != []
                return take_best_corner(board)
            end

            board.cells.each_with_index do |space, index|
                if space == " "
                    index = index + 1
                    move = index.to_s
                    return move
                end
            end
        end

        def middle?(board)
            board.valid_move?(5)
        end

        def corners?(board)
            corners_array = []
            board.cells.each_with_index do |space, index|
                move = index + 1
                if move.odd? && board.valid_move?(move)
                    corners_array << move
                end
            end
            corners_array
        end

        def take_best_corner(board)
            avail_corners = corners?(board)
            corners_to_win = []
            corners_with_one = []
            avail_corners.each do |corner|
                WIN_COMBINATIONS.each do |individual_combo| 
                    if individual_combo.include?(corner - 1)
                        win_index_1 = individual_combo[0]
                        win_index_2 = individual_combo[1]
                        win_index_3 = individual_combo[2]
                
                        position_1 = board.cells[win_index_1]
                        position_2 = board.cells[win_index_2]
                        position_3 = board.cells[win_index_3]

                        contents = [position_1, position_2, position_3]
                        how_many_o = contents.count("O")
                        if how_many_o == 2
                            corners_to_win << corner
                        elsif how_many_o == 1
                            corners_with_one << corner
                        end
                    end
                end
            end
            if corners_to_win != []
                move = corners_to_win[0]
                return move
            elsif corners_with_one != []
                move =  corners_with_one[0]
                return move
            else
                return avail_corners[0]
            end
        end
        #end of take best corner

    end
    #end of move 
    
  end