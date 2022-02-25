require "pry-byebug"

class Game
	
	def initialize
		restart_game
	end

	def start
		display_table
		@game_in_progress = true
		while @game_in_progress
			play_round(@current_player)
			@current_player = @current_player == @player_one ? @player_two : @player_one
		end
	end

	def display_table
		for line in @play_table
				puts line.join("|")
		end
	end

	def play_round(player)
		
			if @choices_number == 9
				return finish_game(nil)
			end
			
			get_choice(player)
			if did_win?(player)
				player.score += 1
				return finish_game(player) 
			else 
				display_table
			end
	
	end

	def get_choice(player)
		puts "Please make your choice (#{player.name})"
		choice = gets.chomp.to_i
		@choices_number += 1
			case choice
			when 1
				@play_table[0][0] = player.symbol
			when 2
				@play_table[0][1] = player.symbol
			when 3
				@play_table[0][2] = player.symbol
			when 4
				@play_table[1][0] = player.symbol
			when 5
				@play_table[1][1] = player.symbol
			when 6
				@play_table[1][2] = player.symbol
			when 7
				@play_table[2][0] = player.symbol
			when 8
				@play_table[2][1] = player.symbol
			when 9
				@play_table[2][2] = player.symbol
			end
	end
		
	def did_win?(player)
		i = 0
		while i < 3
			j = 0	
			if @play_table[i][j] == @play_table[i][j + 1] && @play_table[i][j] == @play_table[i][j + 2]
				return true
			end
			if @play_table[j][i] == @play_table[j + 1][i] && @play_table[j][i] == @play_table[j + 2][i]
				return true
			end
			i += 1
		end
		if @play_table[0][0] == @play_table[1][1] && @play_table[0][0] == @play_table[2][2]
			return true
		end
		if @play_table[2][0] == @play_table[1][1] && @play_table[1][1] == @play_table[0][2]
			return true
		end
		return false
	end

	def finish_game(winner)
		game_in_progress = false
		if winner == nil 
			puts "It's a tie!"
		else
			puts "Winner is #{winner.name}. Congratulations!"
		end

		puts "Score"
		puts "###########"
		puts "#{@player_one.name}: #{@player_one.score}"
		puts "#{@player_two.name}: #{@player_two.score}"
		puts "###########"
		puts ""
		puts "Play again (1)"
		puts "Reset game (2)"

		user_option = gets.chomp
		if user_option == "1"
			reset_game
			start
		else
			restart_game
			start
		end
	end

	def reset_game
		@play_table = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
		@choices_number = 0	
	end

	def restart_game
		@play_table = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
		@player_one = Player.new(1)
		@player_two = Player.new(2)
		@order_number = 1
		@choices_number = 0	
		@game_in_progress = false
		@current_player = @player_one
	end
end

class Player

	attr_accessor :name, :symbol, :score

	def initialize(player_num)
		puts "Enter Player #{player_num} name"
		@name = gets.chomp
		puts "Choose Player #{player_num} symbol"
		@symbol = gets.chomp 
		@score = 0
	end
end


puts "Do you wanna play some Tic-Tac-Toe? Type y or n"
play = gets.chomp
if play == "y"
	new_game = Game.new
	new_game.start
else 
	puts "Sorry to see you go :("
	return
end




