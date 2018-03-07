# define class  Movie
class BaseMovie
  attr_reader :href, :title, :release_year, :country, :release_date, :genre, :full_duration_definition, :duration, :duration_definition, :rating, :director, :actors, :movie_collection

  #defalt period and cost
  COST = 0
  PERIOD = :not_set

  def initialize(args, movie_collection)
    args.map { |k,v| instance_variable_set("@#{k}", v) unless v.nil?}
    @movie_collection = movie_collection
    normalize_attributes
  end

  def cost()
    self.class::COST
  end

  def period()
    self.class::PERIOD
  end

  def to_s
    "#{@title} (#{@release_date}; #{@genre.join(',')}) - #{@duration} #{@duration_definition}  #{@country}"
  end

  def inspect
    "#<Movie \"#{@title}\" (#{@release_year})>"
  end

  def matches_period?(filter)
    filter.any? { |k,v| (send(k).class == Array) ? send(k).any?{|x| v.include?(x) } : matches?(k,v) }
  end

  def matches?(key, value)
    Array(send(key)).any? { |v| value === v}
  end

  private
  def normalize_attributes
    @release_year = @release_year.to_i
    @genre = @genre.split(',')
    @duration = @full_duration_definition.split(' ')[0].to_i
    @duration_definition = @full_duration_definition.split(' ')[1]
    @rating = @rating.to_f
    @actors = @actors.split(',')
  end
end
