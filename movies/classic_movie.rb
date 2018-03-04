# define class  AncientMovie
require './movies/base_movie.rb'
class ClassicMovie < BaseMovie
  COST = 1.5
  PERIOD = :classic

  def cost()
    COST
  end

  def period()
    PERIOD
  end

  def director_films
    @movie_collection.movies.select{ |m| m.director == director && m.title != title }.map { |m| m.title }.join(',')
  end

  def poster_title
    "#{title} — classic movie, director #{director} (#{director_films})"
  end
end
