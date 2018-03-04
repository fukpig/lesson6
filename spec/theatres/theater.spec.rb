require 'spec_helper'
require './theatres/theater.rb'

describe Theater do
  before :each do
    @theater = Theater.new("spec_movies.txt")
  end

  describe ".when?" do
    it "return period" do
      expect(@theater.when?("The Shining")).to eq(:evening)
    end

    it "error with not found movie" do
      expect{@theater.when?("The test")}.to raise_error(BaseTheater::MovieNotFound)
    end

    it "error with not found movie to show" do
      expect{@theater.when?("Once Upon a Time in the West")}.to raise_error(BaseTheater::MovieToShowNotFound)
    end
  end

  describe ".show" do
    it "show" do
      expect(@theater.show("10:00")).to include("Now showing:")
    end

    it "error" do
      expect{@theater.show("07:00")}.to raise_error(Theater::InvalidTimePeriod)
    end
  end
end
