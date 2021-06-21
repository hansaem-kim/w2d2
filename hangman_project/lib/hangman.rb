class Hangman
  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses

  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = []
    @secret_word.length.times {@guess_word << "_"}
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    if @attempted_chars.include?(char)
      return true
    else
      return false
    end
  end

  def get_matching_indices(char)
    indices = []
    @secret_word.each_char.with_index do |letter, i|
      if letter == char
        indices << i 
      end
    end
    indices
  end

  def fill_indices(char, a)
    a.each do |i|
      @guess_word[i] = char
    end
  end

  def try_guess(char)
    if self.already_attempted?(char)
      puts "that has already been attempted"
      return false
    else
      @attempted_chars << char
      indices = self.get_matching_indices(char)
      if indices.length > 0
        self.fill_indices(char, indices)
      else
        @remaining_incorrect_guesses -=1
      end
      return true
    end
  end

  def ask_user_for_guess
    print "Enter a char: "
    input = gets.chomp
    self.try_guess(input)
  end

  def win?
    if @guess_word.join == @secret_word
      puts "WIN"
      return true
    end
    false
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      return true
    end
    false
  end

  def game_over?
    if self.win? || self.lose?
      puts @secret_word
      return true
    end
    false
  end
end
