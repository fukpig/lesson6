require 'spec_helper'
require 'rspec/its'

require './movies/ancient_movie.rb'

describe AncientMovie do
  let(:arguments) { {:href => "http://url.com/", :title => "Citizen Kane", :release_year => "1941", :country => "USA", :release_date => "1941-10-09", :genre => "Drama, Mystery", :full_duration_definition => "103 min", :rating => 8.3, :director => "Orson Welles", :actors => "Herman J. Mankiewicz"} }
  let(:movie) { AncientMovie.new(arguments, nil) }

  describe 'valid ancient movie' do
    subject { movie }

    it 'return ancient on get period' do
      expect(movie.period).to eq :ancient
    end

    it 'return 1 on get cost' do
      expect(movie.cost).to eq 1
    end

    it 'valid poster title' do
      expect(movie.poster_title).to eq "Citizen Kane — old movie (1941 year)"
    end
  end
end
