# define class  BaseTheater
require 'csv'
require './movies/ancient_movie.rb'
require './movies/classic_movie.rb'
require './movies/modern_movie.rb'
require './movies/new_movie.rb'


class BaseTheater
  class FileNotFound < ArgumentError
    attr_reader :filename
    def initialize(filename)
      @filename = filename
      super("File #{filename} not found")
    end
  end

  class MovieNotFound < StandardError
    attr_reader :hash
    def initialize(hash)
      @hash = hash
      super("Movie with params #{hash.to_s} not found")
    end
  end

  attr_reader :movies, :genres

  MOVIE_HASH_KEYS = %i[href title release_year country release_date genre full_duration_definition rating director actors]

  def initialize(filename)
    raise FileNotFound.new(filename) unless File.file? filename
    @movies = CSV.read(filename, { headers: MOVIE_HASH_KEYS, col_sep: "|" }).map { |row| create_movie(row.to_hash, self) }
    @genres = @movies.flat_map(&:genre).uniq
  end

  def inspect
    "#<MovieCollection movies: #{@movies}>"
  end

  def all
    @movies
  end

  def filter(filters)
    filters.reduce(@movies) { |filtered, (key, value)| filtered.select { |m| m.matches?(key, value) } }
  end

  def show(movie)
    current_time = Time.now.strftime("%H:%M")
    movie_end_time = (Time.now + movie.duration*60).strftime("%H:%M")
    puts "Now showing: #{movie.title} #{current_time} - #{movie_end_time}"
  end

  private
  def create_movie(movie_hash, theater)
    case movie_hash[:release_year].to_i
    when 1900..1944
      return AncientMovie.new(movie_hash, theater)
    when 1945..1967
      return ClassicMovie.new(movie_hash, theater)
    when 1968..1999
      return ModernMovie.new(movie_hash, theater)
    else
      return NewMovie.new(movie_hash, theater)
    end
  end

end
