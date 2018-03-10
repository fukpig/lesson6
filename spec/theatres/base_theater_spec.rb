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
      expect(theater.filter(director: /Stanley Kubrick/)).to all have_attributes(director: 'Stanley Kubrick')
      expect(theater.filter(period: :classic)).to all have_attributes(period: :classic)
      expect(theater.filter(country: "USA")).to all have_attributes(country: "USA")
      expect(theater.filter(actors: "Clint Eastwood")).to all have_attributes(actors: array_including('Clint Eastwood'))
      expect(theater.filter(genre: 'Drama')).to all have_attributes(genre: array_including('Drama'))
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

    it 'check valid classes' do
      expect(theater.movies[0]).to be_a ModernMovie
      expect(theater.movies[1]).to be_a AncientMovie
      expect(theater.movies[2]).to be_a ClassicMovie
      expect(theater.movies[3]).to be_a NewMovie
    end
  end
end
