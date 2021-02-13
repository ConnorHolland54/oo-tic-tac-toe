require 'set'
require 'pry'

class TicTacToe
    attr_accessor :board

    WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]

    def initialize
        @board = Array.new(9, " ")
    end

    def display_board
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------------------------------------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------------------------------------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def input_to_index(input)
        number = input.to_i 
        array_format = number - 1
    end

    def move(space, player)
        @board[space] = player
    end

    def position_taken?(index)
        if @board[index] == "X" || @board[index] == "O"
            return true
        else
            return false
        end
    end 

    def valid_move?(index)
        !position_taken?(index) && index.between?(0,8)
    end



    def turn_count
        count = 0
        @board.each do |x|
            if x == "X" || x == "O"
                count += 1
            end
        end
        return count
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
        puts "Please enter a number (1-9):"
        user_input = gets.strip
        index = input_to_index(user_input)
        if valid_move?(index)
            token = current_player
            move(index, token)
        else
            turn
        end
        display_board
    end

    def won?
        x_index = []
        o_index = []
        x_subset = []
        o_subset = []
        i = 0
            
            while i < board.length
                if board[i] == "X"
                    x_index << i
                elsif board[i] == "O"
                    o_index << i
                end
                    i += 1
                end
               
                WIN_COMBINATIONS.each do |comb|
                    if comb.to_set.subset?(x_index.to_set) || comb.to_set.subset?(o_index.to_set)
                        return comb
                    end
                end
        return false
    end

    def full?
        if @board.include?(" ")
            return false
        elsif won? == false
            return true
        end
    end

    def draw?
        if full?
            return true
        else
            return false
        end
    end

    def over?
        if full? || won? != false
            return true
        else
            return false
        end
    end

    def winner
        if won? != false
            return @board[won?[0]]
            binding.pry
        else 
            return nil
        end
    end

    def play    
        if over? == false && draw? == false
            turn
            play
        elsif won? != false
            puts("Congratulations #{winner}!")
        elsif draw?
            puts("Cat's Game!")
        end
    end
end
