require 'spec_helper'
require './movies/ancient_movie.rb'

describe AncientMovie do
  before :each do
    args = {:href => "http://url.com/", :title => "Citizen Kane", :release_year => "1941", :country => "USA", :release_date => "1941-10-09", :genre => "Drama, Mystery", :full_duration_definition => "103 min", :rating => 8.3, :director => "Orson Welles", :actors => "Herman J. Mankiewicz"}
    @movie = AncientMovie.new(args, nil)
  end

  describe ".poster_title" do
    it "return base poster title" do
      expect(@movie.poster_title).to eq("#{@movie.title} — old movie (#{@movie.release_year} year)")
    end
  end

  describe ".period" do
    it "return ancient period" do
      expect(@movie.period).to eq(:ancient)
    end
  end

  describe ".cost" do
    it "return 1 cost" do
      expect(@movie.cost).to eq(1)
    end
  end
end
