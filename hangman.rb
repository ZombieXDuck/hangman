
class Hangman
  def initialize
    @hangmanWords = []
    @rand = 0
    @selectedWord = ""
    @turn = 0
    @guess = ""
  end

  def read_file
    lines = File.readlines "5desk.txt"
    lines.each do |word|
      word = word.chomp
      @hangmanWords.push(word) if word.length >= 5 && word.length <= 12
    end
  end

  def select_word
    @selectedWord = @hangmanWords[rand(@hangmanWords.length)]
    @selectedWord.split('')
  end

  def guess
    print "Enter your guess: "
    @guess = gets.chomp
  end

  def compare
    @selectedWord.each_with_index do |letter,index|
      matches.push(index) if @guess == x
    end
  end

  def play
    read_file
    select_word
    until @gameover == TRUE || @turn == 20
      @turn += 1
      guess
      compare
  end
end

newGame = Hangman.new
newGame.play
