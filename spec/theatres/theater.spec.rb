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
      expect{theater.when?("Scream")}.to raise_error(BaseTheater::MovieNotFound)
    end
  end

  describe '#show' do
    let(:current_time) { Time.now.strftime("%H:%M") }

    context "check morning classic movie" do
      let (:movie) { double("ClassicMovie") }
      it 'show film from morning period' do
        movie.stub(:duration) { 100 }
        movie.stub(:title) { "The thing" }
        theater.stub(:filter) { [movie] }

        movie_end_time = (Time.now + movie.duration*60).strftime("%H:%M")
        expect(theater.show("10:00")).to eq "Now showing: The thing #{current_time} - #{movie_end_time}"
      end
    end

    context "check day adventure or comedy movie" do
    let (:movie) { double("ModernMovie") }
      it 'get adventure film' do
        movie.stub(:duration) { 110 }
        movie.stub(:title) { "Indiana Jones" }
        movie.stub(:genre) { ["Adventure"]}
        theater.stub(:filter) { [movie] }

        movie_end_time = (Time.now + movie.duration*60).strftime("%H:%M")
        expect(theater.show("13:00")).to eq "Now showing: Indiana Jones #{current_time} - #{movie_end_time}"
      end

      it 'get comedy film' do
        movie.stub(:duration) { 110 }
        movie.stub(:title) { "Dumb and dumber" }
        movie.stub(:genre) { ["Comedy"]}
        theater.stub(:filter) { [movie] }

        movie_end_time = (Time.now + movie.duration*60).strftime("%H:%M")
        expect(theater.show("13:00")).to eq "Now showing: Dumb and dumber #{current_time} - #{movie_end_time}"
      end
    end

    context "check day horror or drama movie" do
    let (:movie) { double("ModernMovie") }
      it 'get horror film' do
        movie.stub(:duration) { 110 }
        movie.stub(:title) { "Alien" }
        movie.stub(:genre) { ["Horror"]}
        theater.stub(:filter) { [movie] }

        movie_end_time = (Time.now + movie.duration*60).strftime("%H:%M")
        expect(theater.show("21:00")).to eq "Now showing: Alien #{current_time} - #{movie_end_time}"
      end

      it 'get drama film' do
        movie.stub(:duration) { 110 }
        movie.stub(:title) { "Bridgit jones" }
        movie.stub(:genre) { ["Drama"]}
        theater.stub(:filter) { [movie] }

        movie_end_time = (Time.now + movie.duration*60).strftime("%H:%M")
        expect(theater.show("21:00")).to eq "Now showing: Bridgit jones #{current_time} - #{movie_end_time}"
      end
    end

    context "get error with invalid time" do
      it "return invalid time period" do
        expect{theater.show("07:00")}.to raise_error(Theater::InvalidTimePeriod)
      end
    end

=begin
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
=end
  end
end
