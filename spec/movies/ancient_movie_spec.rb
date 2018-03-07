require 'spec_helper'
require 'rspec/its'

require './movies/ancient_movie.rb'

describe AncientMovie do
  let(:arguments) { {:href => "http://url.com/", :title => "Citizen Kane", :release_year => "1941", :country => "USA", :release_date => "1941-10-09", :genre => "Drama, Mystery", :full_duration_definition => "103 min", :rating => 8.3, :director => "Orson Welles", :actors => "Herman J. Mankiewicz"} }
  let(:movie) { AncientMovie.new(arguments, nil) }

  describe '#period' do
    subject { movie }
    its(:period) { is_expected.to eq :ancient }
  end

  describe '#cost' do
    subject { movie }
    its(:cost) { is_expected.to eq 1 }
  end

  describe '#poster_title' do
    subject { movie }
    its(:poster_title) { is_expected.to eq "Citizen Kane — old movie (1941 year)" }
  end
end
