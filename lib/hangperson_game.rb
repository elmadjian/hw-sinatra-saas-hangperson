class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  #guess if a word is valid
  def guess(letter)
    raise ArgumentError if not letter =~ /[A-z]/
    letter.downcase!
    return false if @guesses.include? letter or @wrong_guesses.include? letter
    (@word.include? letter)? @guesses << letter : @wrong_guesses << letter
  end

  #display the guessed word so far
  def word_with_guesses
    guess = ''
    @word.each_char {|c| guess << ((@guesses.include? c)? c : '-')}
    return guess
  end

  #check for victory or shameful loss
  def check_win_or_lose
    win = true
    @word.each_char {|c| win = false if not @guesses.include? c}
    return :lose if @wrong_guesses.length >= 7
    return win ? :win : :play
  end

  #get random word from web
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
