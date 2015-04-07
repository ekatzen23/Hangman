#save game (resume game)

class Hangman
    attr_reader :secret_word, :correct_letters, :incorrect_letters, :turn_count
	def initialize
	  @secret_word = get_word
	  @secret_word.downcase!
	  @correct_letters = ""
	  @incorrect_letters = ""
	  @turn_count = 10
	end
	
	# Method called to initialize the game
	def start_game
	  puts "Welcome to Hangman! A secret word has been chosen. You have #{turn_count} guesses to get the word correct. Good luck!"
	  (@secret_word.size).times { @correct_letters += "_ " }
	  puts @correct_letters
	  begin_guessing
	end
	
	private
	
	# Defines the process for when the user begins guessing letters and words.
	def begin_guessing
	  while @turn_count > 0 do
	    puts "\nPlease enter 'guess' if you would like to guess the word. Otherwise, please enter a single letter guess."
	    guess_input = gets.chomp
		
		# Handles the case if the user wants to guess the word
		if guess_input.downcase == "guess"
		  puts "\nPlease enter your guess."
		  full_guess = gets.chomp
		  full_guess.downcase!
		  if full_guess == @secret_word 
		    win_game 
		  else 
		    @turn_count -= 1
		    puts "\nIncorrect guess."
			end_turn
		  end
		  
		# Handles the case if the user wants to guess a letter
		else
	      guess_letter = guess_input[0].downcase
	      game_board(guess_letter)
		end
	  end
	  lose_game if @turn_count == 0
	end
	
	# This method runs when the user enters a letter as a guess
	def game_board(guess_letter)
	  puts ""	  
	  result_index_array = (0 ... @secret_word.length).find_all { |i| @secret_word[i,1] == guess_letter }
	  
	  # Change the output to show a successful guess
	  if result_index_array.size == 0
	    @incorrect_letters += guess_letter
		@incorrect_letters += ", "
	  else 
	    result_index_array.each { |index| @correct_letters[2*index] = guess_letter }
      end
	  
	  # Update variables and check if the game has been won
	  @turn_count -= 1
	  puts @correct_letters
	  #@incorrect_letters.each {|letter| print "#{letter}, "}
	  puts "\nIncorrect Guesses: #{@incorrect_letters}"
	  win_game if @correct_letters.count('_') == 0
	  end_turn
	end
	
	def lose_game
	  puts "You are out turns. You lose."
	  puts "The word was #{@secret_word}!"
	  exit
	end
	
	def win_game
	  puts "\nCongratulations. You won!"
	  puts "-------------------------------------------"
	  exit
	end
	
	def end_turn
	  puts "You have #{@turn_count} guesses left."
	  puts "-------------------------------------------"
	end
	
	# Picks a random word that is <= 5 <= 12 characters long
	def get_word
	  # Variable initialization
	  wordArray = []
	  count = 0
	  random_int = 0
	  
	  # Stores each word that is on a new line into an array
	  f = File.open("5desk.txt", "r")
	  f.each_line{ |line| wordArray << line }
	  f.close
	   
	  # Selects the random word between the desired length of between 5 and 12 characters. 
	  # Note that this includes an extra delimiter at the end of each word
	  until wordArray[random_int].length > 5 && wordArray[random_int].length < 14 do
	    random_int = Random.new.rand(0..61405)
	  end
	  wordArray[random_int].chomp!
	end
end

game = Hangman.new()
game.start_game()

