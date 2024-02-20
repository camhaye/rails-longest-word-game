require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    vowels = ["a", "e", "i", "o", "u", "y"]
    consons = ('a'..'z').to_a - vowels
    @letters = []
    10.times { @letters << consons.sample }
    5.times { @letters << vowels.sample }
    @letters = @letters.shuffle
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    word_exist = URI.open(url).read
    result = JSON.parse(word_exist)

    points = params[:word].split("").length

    if session[:score]
      session[:score] += points
    else
      session[:score] = 0
    end

    if result["found"]
      if contains(params[:word])
        @answer = "Congratulations! #{params[:word]} is a valid english word that can be built out of #{params[:letters]}.
        You win #{points} points. You have #{session[:score]} points"
      else
        @answer = "Sorry but #{params[:word]} can't be built out of #{params[:letters]}"
      end
    else
      @answer = "Sorry but #{params[:word]} does not seem to be an english word"
    end

  end

  private

  def contains(word)
    ltrs = word.split("")
    letters = params[:letters].split(" ")
    ltrs.each do |ltr|
      letters.include?(ltr)
      index = letters.index(ltr)
      letters.delete_at(index)
    end
  end
end
