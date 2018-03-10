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
  SCHEDULE = {:morning => {:period => :ancient}, :day => {:genre => Regexp.union(DAY_GENRES)}, :evening => {:genre => Regexp.union(EVENING_GENRES)}, :test => {:genre => Regexp.union(EVENING_GENRES), :period => :modern} }



  def when?(title)
    movie = filter({:title => title}).first
    raise MovieNotFound.new(title: title) if movie.nil?
    time = find_time_by_movie(movie)
    puts "time"
    puts time
    raise MovieNotFound.new(title: title) if time.nil?
    time
  end

  def show(time = Time.now.hour)
    if time.class != Integer
      time = get_hour(time)
    end

    time_period = get_time_period(time)
    raise InvalidTimePeriod if time_period.nil?
    movie = find_movie_by_time(time_period)
    raise MovieNotFound.new(time: time) if movie.nil?
    super(movie)
  end

  private

  def get_hour(time)
    values = time.split(':')
    raise InvalidTime if values.first.nil?
    values.first.to_i
  end

  def get_time_period(hours)
    time = TIME_PERIODS.keys.detect {|k| k.cover? hours }
    TIME_PERIODS[time]
  end

  def find_time_by_movie(movie)
    SCHEDULE.keys.detect { |k|  SCHEDULE[k].detect{ |filter_name, filter_value| movie.matches?(filter_name, filter_value) }  }
  end

  def find_movie_by_time(time)
    filter(SCHEDULE[time]).sample
  end

end
