require 'spec_helper'
require 'rspec/its'

require './theatres/theater.rb'

describe Theater do
  let(:file) { "spec_movies.txt" }
  let(:theater) { Theater.new(file) }

  describe '#when?' do
    it 'find movie' do
      expect(theater.when?("The Shining")).to eq :evening
    end
    it 'get error when movie cant be find in text file' do
      expect{theater.when?("La la land")}.to raise_error(BaseTheater::MovieNotFound)
    end
    it 'get error when movie not in schedule' do
      expect{theater.when?("Once Upon a Time in the West")}.to raise_error(BaseTheater::MovieNotFound)
    end
  end

  describe '#show' do
    let(:current_time) { Time.now.strftime("%H:%M") }
    let(:morning_movie) { theater.filter({title: "Casablanca"}).first }
    let(:morning_movie_end_time) { (Time.now + morning_movie.duration*60).strftime("%H:%M") }

    it 'get film by morning period' do
      expect(theater.show("10:00")).to eq "Now showing: #{morning_movie.title} #{current_time} - #{morning_movie_end_time}"
    end

    #array
    it 'get film by day period' do
      expect(theater.show("13:00")).to include("Now showing:")
    end

    #array
    it 'get film by evening period' do
      expect(theater.show("21:00")).to include("Now showing:")
    end

    it "get error by invalid period" do
      expect{theater.show("07:00")}.to raise_error(Theater::InvalidTimePeriod)
    end
  end
end
