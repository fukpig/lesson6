require 'spec_helper'
require 'rspec/its'

require './movies/modern_movie.rb'

describe ModernMovie do
  let(:arguments) { {:href => "http://url.com/", :title => "The Shining", :release_year => "1980", :country => "USA", :release_date => "1980-10-09", :genre => "Drama, Horror", :full_duration_definition => "103 min", :rating => 8.5, :director => "Stanley Kubrick", :actors => "Jack Nicholson, Ron Swanson"} }
  let(:movie) { ModernMovie.new(arguments, nil) }

  describe '#period' do
    subject { movie }
    its(:period) { is_expected.to eq :modern }
  end

  describe '#cost' do
    subject { movie }
    its(:cost) { is_expected.to eq 3 }
  end

  describe '#poster_title' do
    subject { movie }
    its(:poster_title) { is_expected.to eq "The Shining — modern movie: plays Jack Nicholson, Ron Swanson" }
  end
end
