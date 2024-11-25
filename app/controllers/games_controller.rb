class GamesController < ApplicationController
  def new
    @array = ("A".."Z").to_a.sample(10)
  end

  require "json"
  require "open-uri"
  def score
    @word = params[:word]&.upcase
    @letters = params[:letters]&.split
    @grid_valid = @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }

    url = "https://dictionary.lewagon.com/#{@word}"
    response = URI.open(url).read
    puts response
    @english_word = JSON.parse(response)["found"]

    if !@grid_valid
      @message = "Sorry but #{@word} can't be build out of #{@letters.join(', ')}"
    elsif !@english_word
      @message = "Sorry but #{@word} does not seem to be a valid English word..."
    else
      @message = "Congratulations! #{@word} is a valid English word"
    end
  end
end
