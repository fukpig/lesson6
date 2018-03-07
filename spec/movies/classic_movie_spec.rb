require 'spec_helper'
require 'rspec/its'

require './theatres/base_theatre.rb'
require './movies/classic_movie.rb'

describe ClassicMovie do
  let(:arguments) { {:href => "http://url.com/", :title => "Vertigo", :release_year => "1958", :country => "USA", :release_date => "1958-10-09", :genre => "Mystery, Thriller", :full_duration_definition => "103 min", :rating => 8.3, :director => "Alfred Hitchcock", :actors => "James Stewart"} }
  let(:theater) { BaseTheater.new("spec_movies.txt") }
  let(:movie) { ClassicMovie.new(arguments, theater) }

  describe '#period' do
    subject { movie }
    its(:period) { is_expected.to eq :classic }
  end

  describe '#cost' do
    subject { movie }
    its(:cost) { is_expected.to eq 1.5 }
  end

  describe '#poster_title' do
    subject { movie }
    its(:poster_title) { is_expected.to eq "Vertigo — classic movie, director Alfred Hitchcock (still in the top 1 of his films)" }
  end
end
