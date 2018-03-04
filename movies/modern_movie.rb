# define class  AncientMovie
require './movies/base_movie.rb'
class ModernMovie < BaseMovie
  COST = 3
  PERIOD = :modern

  def cost()
    COST
  end

  def period()
    PERIOD
  end

  def poster_title
    "#{title} — modern movie: plays #{actors.join(',')}"
  end
end
