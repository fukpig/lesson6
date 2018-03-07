require 'spec_helper'
require 'rspec/its'

require './movies/new_movie.rb'

describe NewMovie do
  let(:arguments) { {:href => "http://url.com/", :title => "Mad Max: Fury Road", :release_year => "2015", :country => "USA", :release_date => "2015-10-09", :genre => "Action, Adventure, Sci-Fi", :full_duration_definition => "103 min", :rating => 8.1, :director => "George Miller", :actors => "Tom Hardy, Charlize Theron"} }
  let(:movie) { NewMovie.new(arguments, nil) }

  describe '#period' do
    subject { movie }
    its(:period) { is_expected.to eq :new }
  end

  describe '#cost' do
    subject { movie }
    its(:cost) { is_expected.to eq 5 }
  end

  describe '#poster_title' do
    subject { movie }
    its(:poster_title) { is_expected.to eq "Mad Max: Fury Road — new film, came out 3 years ago!" }
  end
end
