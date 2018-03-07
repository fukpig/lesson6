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
  SCHEDULE = {:morning => {:period => :ancient}, :day => {:genre => DAY_GENRES.sample}, :evening => {:genre => EVENING_GENRES.sample}}
  SCHEDULE_FULL = {:morning => {:period => :ancient}, :day => {:genre => DAY_GENRES}, :evening => {:genre => EVENING_GENRES}}



  def when?(title)
    movie = filter({:title => title}).first
    raise MovieNotFound.new(title) if movie.nil?
    time = find_time_by_movie(movie)
    raise MovieNotFound.new(title: title) if time.nil?
    return time
  end

  def show(time = Time.now.hour)
    if time.class != Integer
      time = get_hour(time)
    end

    time_period = get_time_period(time)
    raise InvalidTimePeriod.new if time_period.nil?
    movie = find_movie_by_time(time_period)
    raise MovieNotFound.new(time: time) if movie.nil?
    super(movie)
  end

  private

  def get_hour(time)
    values = time.split(':')
    raise InvalidTime.new if values.first.nil?
    return values.first.to_i
  end

  def get_time_period(hours)
    time = TIME_PERIODS.keys.detect {|k| k.cover? hours }

    return TIME_PERIODS[time]
  end

  def find_time_by_movie(movie)
    SCHEDULE_FULL.keys.detect { |k| movie.matches_period?(SCHEDULE_FULL[k]) }
  end

  def find_movie_by_time(time)
    return filter(SCHEDULE[time]).sample
  end

end
