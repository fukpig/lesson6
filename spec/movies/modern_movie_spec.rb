require 'spec_helper'
require './movies/modern_movie.rb'

describe ModernMovie do
  before :each do
    args = {:href => "http://url.com/", :title => "The Shining", :release_year => "1980", :country => "USA", :release_date => "1980-10-09", :genre => "Drama, Horror", :full_duration_definition => "103 min", :rating => 8.5, :director => "Stanley Kubrick", :actors => "Jack Nicholson"}
    @movie = ModernMovie.new(args, nil)
  end

  describe ".poster_title" do
    it "return poster title" do
      expect(@movie.poster_title).to eq("#{@movie.title} — modern movie: plays #{@movie.actors.join(',')}")
    end
  end

  describe ".period" do
    it "return modern period" do
      expect(@movie.period).to eq(:modern)
    end
  end

  describe ".cost" do
    it "return 3 cost" do
      expect(@movie.cost).to eq(3)
    end
  end
end
