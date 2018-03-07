# define class  Netflix
require 'csv'
require './theatres/base_theatre.rb'

class Netflix < BaseTheater
  class PaymentError < StandardError
    def initialize()
      super("Payment Error")
    end
  end

  class WithdrawError < StandardError
    def initialize()
      super("Withdraw Error")
    end
  end

  attr_reader :wallet
  def initialize(filename)
    super(filename)
    @wallet = 0
  end

  def check_money(amount)
    raise WithdrawError.new if (@wallet - amount) < 0
  end

  def withdraw(amount)
    check_money(amount)
    @wallet -= amount
  end

  def pay(amount)
    raise PaymentError.new unless amount > 0
    @wallet += amount
  end

  def how_much?(title)
    movie = filter({:title => title}).first
    raise MovieNotFound.new(title: title) if movie.nil?
    movie.cost
  end

  def show(filter_hash = nil)
    if filter_hash.nil?
      movie = movies.sample
    else
      movie = get_filtered_film(filter_hash)
    end

    withdraw(movie.cost)
    super(movie)
  end

  private

  def get_filtered_film(filter_hash)
    filtered_movies = filter(filter_hash)
    movie = filtered_movies.sample
    raise MovieNotFound.new(filter_hash) if movie.nil?
    return movie
  end
end
