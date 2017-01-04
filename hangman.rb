class Hangman
  def initialize
    @hangman_words = []
    @selected_word = ""
    @player_guess = ""
    @correct_letters = []
    @wrong_letters = []
    @turn = 1
  end

  def read_file
    lines = File.readlines "5desk.txt"
    lines.each do |word|
      word = word.chomp.downcase
      @hangman_words.push(word) if word.length >= 5 && word.length <= 12
    end
  end

  def select_word
    @selected_word = @hangman_words[rand(@hangman_words.length)]
    @selected_word.length.times do |i|
      @correct_letters[i] = "_"
    end
  end

  def draw_board
    puts "Correct: #{@correct_letters}"
    puts "Wrong: #{@wrong_letters}"
    puts "Turn: #{@turn}/20"
  end

  def guess
    print "\nEnter your guess('1' to save & exit): "
    @player_guess = gets.chomp.downcase.chr
    save_game if @player_guess == "1"
  end

  def compare
    matched = FALSE
    @selected_word.length.times do |i|
      if @player_guess == @selected_word[i]
        @correct_letters[i] = @player_guess
        matched = TRUE
      end
    end
    @wrong_letters.push(@player_guess) unless matched == TRUE || @wrong_letters.include?(@player_guess)
  end

  def check_win
    correct_word = @correct_letters.join("")
    if @selected_word == correct_word
      puts "You correctly guessed the word!"
      draw_board
      @gameover = TRUE
    end
  end

  def save_game
    puts("Saving Game...")
    File.open("save_file", "w").puts Marshal.dump(self)
    exit(0)
  end

  def load_game
    loaded_game = Marshal.load(File.open("save_file", "r"))
    loaded_game.play
  end

  def file_select
    puts("(N)ew game or (L)oad game: ")
    input = gets.chomp.downcase()
    if input == "l"
      puts("Loading game...")
      load_game
    elsif input == "n"
      puts("Starting a new game...")
      play
    else
      puts "Incorrect Input, try again"
      file_select
    end
  end

  def start
    read_file #reads in 5desk.txt
    select_word #selects a word from 5desk.txt
    file_select #Load a game or start a new one
  end

  def play
    puts @selected_word
    until @gameover == TRUE || @turn == 20
      draw_board #prints correct_letters and wrong_letters
      guess #fills player_guess
      compare #fills correct_letters and wrong_letters
      check_win #checks to see if the word is guessed correctly
      @turn += 1
    end
    puts "You did not guess the word" if @turn == 20
  end
end

newGame = Hangman.new
newGame.start
