require 'spec_helper'
require 'rspec/its'

require './movies/base_movie.rb'

describe BaseMovie do
  let(:arguments) { {:href => "url", :title => "The thing", :release_year => "1983", :country => "USA", :release_date => "1983-01-01", :genre => "Horror", :full_duration_definition => "103 min", :rating => 8, :director => 'Carpenter', :actors => "Kurt Russell"} }
  let(:movie) { BaseMovie.new(arguments, nil) }

  describe '#normalize_attributes' do
    subject { movie }

    context 'genres' do
      its(:genre) { is_expected.to eq ["Horror"] }
    end

    context 'release_year' do
      its(:release_year) { is_expected.to be_a(Integer) }
      its(:release_year) { is_expected.to eq 1983 }
    end

    context 'duration' do
      its(:duration) { is_expected.to eq 103 }
    end

    context 'duration_definition' do
      its(:duration_definition) { is_expected.to eq "min" }
    end

    context 'rating' do
      its(:rating) { is_expected.to be_a(Float) }
      its(:rating) { is_expected.to eq 8.0 }
    end

    context 'actors' do
      its(:actors) { is_expected.to eq ["Kurt Russell"] }
    end

  end

  describe '#period' do
    subject { movie }
    its(:period) { is_expected.to eq :not_set }
  end

  describe '#cost' do
    subject { movie }
    its(:cost) { is_expected.to eq 0 }
  end

  describe '#matches?' do
    subject { movie.matches?(filter, value) }

    context 'release_year' do
      let(:filter) { :release_year }
      context 'when matches' do
        let(:value) { 1983 }
        it { is_expected.to be_truthy }
      end
      context 'when not matches' do
        let(:value) { 2010 }
        it { is_expected.to be_falsy }
      end
      context 'when range matches' do
        let(:value) { 1980..2010 }
        it { is_expected.to be_truthy }
      end
      context 'when range not matches' do
        let(:value) { 2005..2010 }
        it { is_expected.to be_falsy }
      end
    end

    it 'works with simple values' do
      expect(movie.matches?(:release_year, 1983)).to be_truthy
      expect(movie.matches?(:release_year, 2010)).to be_falsy
      expect(movie.matches?(:title, 'The thing')).to be_truthy
      expect(movie.matches?(:title, 'Mad max')).to be_falsy
    end

    it 'works with patterns' do
      expect(movie.matches?(:release_year, 1980..1990)).to be_truthy
      expect(movie.matches?(:release_year, 1990..2000)).to be_falsy
      expect(movie.matches?(:title, /thing/i)).to be_truthy
      expect(movie.matches?(:title, /mad/i)).to be_falsy
    end
  end

  describe '#matches_period?' do
    subject { movie.matches_period?(filter_hash) }

    context 'period' do
      let(:filter_hash) { :filter_hash }
      context 'when matches' do
        let(:filter_hash) { {:period => :not_set} }
        it { is_expected.to be_truthy }
      end
      context 'when not matches' do
        let(:filter_hash) { {:period => :classic} }
        it { is_expected.to be_falsy }
      end
    end

    context 'genres' do
      let(:filter_hash) { :filter_hash }
      context 'when matches' do
        let(:filter_hash) { { :genre => ["Horror", "Drama"] } }
        it { is_expected.to be_truthy }
      end
      context 'when not  matches' do
        let(:filter_hash) { { :genre => ["Tragedy"] } }
        it { is_expected.to be_falsy }
      end
    end

  end
end
