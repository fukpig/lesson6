require 'spec_helper'

require './movies/base_movie.rb'

describe BaseMovie do
  before :each do
    args = {:href => "url", :title => "The thing", :release_year => "1983", :country => "USA", :release_date => "1983-01-01", :genre => "Horror", :full_duration_definition => "103 min", :rating => 8, :director => 'Carpenter', :actors => "Kurt Russell"}
    @movie = BaseMovie.new(args, nil)
  end

  describe ".matches" do
    it "return true " do
      expect(@movie.matches?("release_year", 1983)).to eq(true)
    end

    it "return false " do
      expect(@movie.matches?("release_year", 2010)).to eq(false)
    end
  end
end
