class Board
    attr_accessor :cells


    def initialize
        @cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    def reset!
        @cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    def display
        puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
        puts "-----------"
        puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
        puts "-----------"
        puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
    end

    def position(user_input)
        index = user_input.to_i - 1
        @cells[index]
    end

    def full?
        !@cells.include?(" ")
    end

    def turn_count
        count = 0
        @cells.each do |cell|
            if cell != " "
                count += 1
            end
        end
        count
    end

    def taken?(input)
        index = input.to_i - 1
        @cells[index] != " "
    end

    def valid_move?(input)
        !taken?(input) && input.to_i.between?(1,9)
    end

    def update(space, player)
        index = space.to_i - 1
        @cells[index] = player.token
    end

end