require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    json = JSON.parse(response.read)
    if json['found'] &&  params[:word].chars.all? { |letter| params[:word].count(letter) <= params[:letters].count(letter) }
      @score = "Congratulations #{params[:word].capitalize} is a valid word!"
    elsif !params[:word].chars.all? { |letter| params[:word].count(letter) <= params[:letters].count(letter) }
      @score = "Sorry #{params[:word]} can't be built out of #{params[:letters]}"
    else
      @score = "Sorry but #{params[:word]} does not seem to be a valid english word"
    end
  end
end
