require 'spec_helper'
require './movies/classic_movie.rb'

describe ClassicMovie do
  before :each do
    @theater = BaseTheater.new("spec_movies.txt")
    args = {:href => "http://url.com/", :title => "Vertigo", :release_year => "1958", :country => "USA", :release_date => "1958-10-09", :genre => "Mystery, Thriller", :full_duration_definition => "103 min", :rating => 8.3, :director => "Alfred Hitchcock", :actors => "James Stewart"}
    @movie = ClassicMovie.new(args, @theater)
  end

  describe ".poster_title" do
    it "return base poster title" do
      expect(@movie.poster_title).to eq("#{@movie.title} — classic movie, director #{@movie.director} (#{@movie.director_films})")
    end
  end

  describe ".period" do
    it "return classic period" do
      expect(@movie.period).to eq(:classic)
    end
  end

  describe ".cost" do
    it "return 1.5 cost" do
      expect(@movie.cost).to eq(1.5)
    end
  end
end
