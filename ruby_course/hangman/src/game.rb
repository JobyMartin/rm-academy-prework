require_relative 'board'
require 'yaml'

class HangmanGame
  attr_reader :code_word
  def initialize
    @board = Board.new
    @all_words = File.read("./words.txt").split("\n")
    @code_word = nil
    @guess_count = 0
  end

  def get_word
    valid_words = []

    @all_words.each do |word|
      if word.length >= 5 && word.length <= 12
        valid_words << word
      end
    end

    @code_word = valid_words.sample
  end

  def create_board
    @code_word.chars.each_with_index do |char, i|
      @board.letters[i] = "_"
    end
  end

  def show_board
    system("clear")
    @board.show
  end

  def get_guess
    print 'Enter letter guess or full word (SAVE to save game): '
    gets.chomp
  end

  def evaluate_guess(guess)
    if guess.length == 1
      already_guessed = @board.wrong_letters.include?(guess) || @board.letters.values.include?(guess)

      if already_guessed
        puts "You already guessed '#{guess.upcase}'. Try a different letter."
        sleep(2)
        return
      end

      @guess_count += 1

      if @code_word.include?(guess)
        @code_word.chars.each_with_index do |char, i|
          @board.letters[i] = char if char == guess
        end
      else
        @board.wrong_letters << guess
        @board.attempt_count -= 1
      end
    else

      @guess_count += 1

      if @code_word == guess
        @code_word.chars.each_with_index do |char, i|
          @board.letters[i] = char
        end
      else
        @board.attempt_count -= 1
        puts 'Incorrect word.'
        sleep(1.5)
      end
    end
  end

  def game_won?
    @code_word == @board.letters.values.join
  end

  def turn
    guess = get_guess

    if guess.upcase == "SAVE"
      save_game
      puts "Game saved."
      exit
    end

    until guess.length > 0
      puts "Please enter a single letter or a full word."
      guess = get_guess
    end

    evaluate_guess(guess)

    show_board
  end

  def play
    print "Welcome to Hangman! Would you like to load a saved game? (Y/N): "
    load_choice = gets.chomp.upcase

    if load_choice == "Y" && File.exist?("save.yml")
      load_game
    else
      get_word
      create_board
    end

    show_board

    until @board.attempt_count == 0 || game_won?
      turn
    end

    if game_won?
      puts "Correct! The word was #{@code_word}. It took you #{@guess_count} guesses."
    else
      puts "You lose! The word was #{@code_word}. Try again!"
    end
  end

  def save_game
    data = {
      code_word: @code_word,
      letters: @board.letters,
      wrong_letters: @board.wrong_letters,
      attempts: @board.attempt_count,
      guess_count: @guess_count
    }

    File.write("save.yml", YAML.dump(data))
  end

  def load_game
    data = YAML.load_file("save.yml")

    @code_word = data[:code_word]
    @board = Board.new
    @board.letters = data[:letters]
    @board.wrong_letters = data[:wrong_letters]
    @board.attempt_count = data[:attempts]
    @guess_count = data.fetch(:guess_count) do
      correct_count = @board.letters.values.uniq.count { |value| value != '_' }
      wrong_count = @board.wrong_letters.length
      correct_count + wrong_count
    end
  end
end
