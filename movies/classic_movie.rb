# define class  AncientMovie
require_relative 'base_movie.rb'
class ClassicMovie < BaseMovie
  COST = 1.5
  PERIOD = :classic

  def director_films
    count = @movie_collection.movies.select{ |m| m.director == director && m.title != title }.count
    if count > 0
      return "(still in the top #{count} of his films)"
    end
    return ""
  end

  def poster_title
    "#{title} — classic movie, director #{director} #{director_films}"
  end
end
