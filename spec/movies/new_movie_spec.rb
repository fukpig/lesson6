require 'spec_helper'
require './movies/new_movie.rb'


describe NewMovie do
  before :each do
    #theater = BaseTheater.new("movies.txt")
    args = {:href => "http://url.com/", :title => "Mad Max: Fury Road", :release_year => "2015", :country => "USA", :release_date => "2015-10-09", :genre => "Action, Adventure, Sci-Fi", :full_duration_definition => "103 min", :rating => 8.1, :director => "George Miller", :actors => "Tom Hardy, Charlize Theron"}
    @movie = NewMovie.new(args, nil)
  end

  describe ".poster_title" do
    it "return base poster title" do
      expect(@movie.poster_title).to eq("#{@movie.title} — new film, came out #{@movie.release_years_ago} years ago!")
    end
  end

  describe ".period" do
    it "return new period" do
      expect(@movie.period).to eq(:new)
    end
  end

  describe ".cost" do
    it "return 5 cost" do
      expect(@movie.cost).to eq(5)
    end
  end
end
