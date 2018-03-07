require 'spec_helper'
require 'rspec/its'

require './theatres/base_theatre.rb'

describe BaseTheater do
  let(:file) { "spec_movies.txt" }
  let(:theater) { BaseTheater.new(file) }

  describe '#all' do
    subject { theater }
    it 'return array with all movies' do
      expect(theater.all.count).to eq 6
    end
  end

  describe '#filter' do
    subject { theater.filter(filter_hash) }
    it 'works with patterns' do
      expect(theater.filter({:title => "Million Dollar Baby"}).first.title).to eq "Million Dollar Baby"
      expect(theater.filter({:release_year => 2019..2020}).first).to be_nil
    end
  end

  describe '#show' do
    subject { theater.show(movie) }
    let(:movie) { theater.movies.first }
    let(:current_time) { Time.now.strftime("%H:%M") }
    let(:movie_end_time) { (Time.now + movie.duration*60).strftime("%H:%M") }
    it 'show movie' do
      expect(theater.show(movie)).to eq "Now showing: The Shining #{current_time} - #{movie_end_time}"
    end
  end

  describe 'factory' do
    subject { theater }

    #be_a not working
    it 'check valid classes' do
      expect(theater.movies[0].class).to eq ModernMovie
      expect(theater.movies[1].class).to eq AncientMovie
      expect(theater.movies[2].class).to eq ClassicMovie
      expect(theater.movies[3].class).to eq NewMovie
    end
  end
end
