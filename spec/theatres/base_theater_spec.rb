require 'spec_helper'
require './theatres/base_theatre.rb'

describe BaseTheater do
  before :each do
    @theater = BaseTheater.new("spec_movies.txt")
  end

  describe ".all" do
    it "return all 6 movies" do
      expect(@theater.all.count).to eq(6)
    end
  end

  describe ".show" do
    it "return film title" do
      @movie = @theater.all.first
      current_time = Time.now.strftime("%H:%M")
      movie_end_time = (Time.now + @movie.duration*60).strftime("%H:%M")
      expect(@theater.show(@movie)).to eq("Now showing: #{@movie.title} #{current_time} - #{movie_end_time}")
    end
  end

  describe ".create_movie" do
    it "check first movies class" do
      @movie = @theater.all[0]
      expect(@movie.class).to eq(ModernMovie)
    end

    it "check second movies class" do
      @movie = @theater.all[1]
      expect(@movie.class).to eq(AncientMovie)
    end

    it "check third movies class" do
      @movie = @theater.all[2]
      expect(@movie.class).to eq(ClassicMovie)
    end

    it "check fourth movies class" do
      @movie = @theater.all[3]
      expect(@movie.class).to eq(NewMovie)
    end
  end

  describe ".filter" do
    it "return film the shing only" do
      filter_hash = {:title => 'The Shining'}
      expect(@theater.filter(filter_hash).first.title).to eq("The Shining")
    end
  end

end
