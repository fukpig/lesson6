# define class  Therater
require 'csv'
require './theatres/base_theatre.rb'

class Theater < BaseTheater
  class InvalidTimePeriod < StandardError
    def initialize()
      super("In that period we doesnt show movies, sorry")
    end
  end

  class InvalidTime < StandardError
    def initialize()
      super("Invalid time, please enter valid time")
    end
  end


  TIME_PERIODS = { 9..11 => :morning, 12..18 => :day, 19..23 => :evening }
  DAY_GENRES = ["Comedy", "Adventure"]
  EVENING_GENRES = ["Horror", "Drama"]

  def when?(title)
    movie = filter({:title => title}).first
    raise MovieNotFound.new(title) if movie.nil?
    time = find_time_by_movie(movie)
    raise MovieToShowNotFound.new if time.nil?
    return time
  end

  def show(time = Time.now.hour)
    if time.class != Integer
      time = get_hour(time)
    end

    time_period = get_time_period(time)
    raise InvalidTimePeriod.new if time_period.nil?
    movie = find_movie_by_time(time_period)
    raise MovieToShowNotFound.new if movie.nil?
    super(movie)
  end

  private

  def get_hour(time)
    values = time.split(':')
    raise InvalidTime.new if values.first.nil?
    return values.first.to_i
  end

  def get_time_period(hours)
    period = TIME_PERIODS.select {|k,v| k === hours}.values.first
  end

  def find_time_by_movie(movie)
    if movie.period == :ancient
      return :morning
    elsif movie.genre.any?{|m| DAY_GENRES.include?(m)}
      return :day
    elsif movie.genre.any?{|m| EVENING_GENRES.include?(m)}
      return :evening
    end
  end

  def find_movie_by_time(time)
    case time
    when :morning
      return filter({:period => :ancient}).sample
    when :day
      return filter({:genre => DAY_GENRES.sample}).sample
    when :evening
      return filter({:genre => EVENING_GENRES.sample}).sample
    end
  end

end
