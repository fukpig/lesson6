# define class  AncientMovie
require './movies/base_movie.rb'
class AncientMovie < BaseMovie
  COST = 1
  PERIOD = :ancient

  def cost()
    COST
  end

  def period()
    PERIOD
  end

  def poster_title
    "#{title} — old movie (#{release_year} year)"
  end
end
