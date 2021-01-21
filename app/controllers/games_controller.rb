require 'open-uri'
require 'json'

class GamesController < ApplicationController
  # TODO: generate random grid of letters
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    @start_time = Time.now
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def score
    @end_time = Time.now
    @word = params[:word]
    @letters = params[:letters].split
    @inlcuded = included?(@word, @letters)
    @english_word = english_word?(@word)
  end
end
