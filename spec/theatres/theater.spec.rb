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
      let (:movie) { double("ClassicMovie", :duration => 100, :title => "The thing") }
      it 'show film from morning period' do
        theater.stub(:filter) { [movie] }
        movie_end_time = (Time.now + movie.duration*60).strftime("%H:%M")
        expect(theater.show("10:00")).to eq "Now showing: The thing #{current_time} - #{movie_end_time}"
      end
    end

    context "check day adventure or comedy movie" do
      context "adventure movie" do
        let (:movie) { double("ModernMovie", :duration => 110, :title => "Indiana Jones", :genre => ["Adventure"]) }
          it 'when adventure film' do
            theater.stub(:filter) { [movie] }
            movie_end_time = (Time.now + movie.duration*60).strftime("%H:%M")
            expect(theater.show("13:00")).to eq "Now showing: Indiana Jones #{current_time} - #{movie_end_time}"
          end
      end

      context "comedy movie" do
        let (:movie) { double("ModernMovie", :duration => 110, :title => "Dumb and dumber", :genre => ["Comedy"]) }
          it 'when adventure film' do
            theater.stub(:filter) { [movie] }
            movie_end_time = (Time.now + movie.duration*60).strftime("%H:%M")
            expect(theater.show("13:00")).to eq "Now showing: Dumb and dumber #{current_time} - #{movie_end_time}"
          end
      end
    end


    context "check evening horror or drama movie" do
      context "adventure movie" do
        let (:movie) { double("ModernMovie", :duration => 110, :title => "Alien", :genre => ["Horror"]) }
          it 'when horror film' do
            theater.stub(:filter) { [movie] }
            movie_end_time = (Time.now + movie.duration*60).strftime("%H:%M")
            expect(theater.show("21:00")).to eq "Now showing: Alien #{current_time} - #{movie_end_time}"
          end
      end

      context "drama movie" do
        let (:movie) { double("ModernMovie", :duration => 110, :title => "Bridgit jones", :genre => ["Drama"]) }
          it 'when drama film' do
            theater.stub(:filter) { [movie] }
            movie_end_time = (Time.now + movie.duration*60).strftime("%H:%M")
            expect(theater.show("21:00")).to eq "Now showing: Bridgit jones #{current_time} - #{movie_end_time}"
          end
      end
    end

    context "get error with invalid time" do
      it "return invalid time period" do
        expect{theater.show("07:00")}.to raise_error(Theater::InvalidTimePeriod)
      end
    end
  end
end
