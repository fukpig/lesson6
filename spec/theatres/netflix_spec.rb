require 'spec_helper'
require 'rspec/its'

require './theatres/netflix.rb'

describe Netflix do
  let(:file) { "spec_movies.txt" }
  let(:netflix) { Netflix.new(file) }

  describe '#withdraw' do
    subject(:withdraw) { netflix.withdraw(5) }
    context 'when enough money' do
      before { netflix.pay(5) }
      it { expect { withdraw } .to change(netflix, :wallet).by(-5) }
    end
    context 'when not enough money' do
      it { expect { withdraw } .to raise_error(Netflix::WithdrawError) }
    end
  end

  describe '#check_money' do
    subject(:check_money) { netflix.check_money(5) }
    context 'when enough money' do
      before { netflix.pay(5) }
      it { expect { check_money } .to_not raise_error }
    end
    context 'when not enough money' do
      it { expect { check_money } .to raise_error(Netflix::WithdrawError) }
    end
  end

  describe '#pay' do
    subject(:pay) { netflix.pay(5) }
    context 'get 5 dollars after payment' do
      it { expect { pay } .to change(netflix, :wallet).by(5) }
    end
  end

  describe '#how_much?' do
    it 'return 3 dollars' do
      expect(netflix.how_much?("The Shining")).to eq 3
    end
  end

  describe '#show' do
    context 'check show' do
      before { netflix.pay(5) }
      let (:movie) { double("ClassicMovie", :cost => 1.5, :duration => 100, :title => "The thing") }
      let(:current_time) { Time.now.strftime("%H:%M") }
      it 'check without filter' do
        netflix.stub(:movies) { [movie] }
        movie_end_time = (Time.now + movie.duration*60).strftime("%H:%M")

        expect(netflix.show()).to eq "Now showing: The thing #{current_time} - #{movie_end_time}"
        expect(netflix.wallet).to eq 3.5
      end

      it 'check with filter' do
        netflix.stub(:filter) { [movie] }
        movie_end_time = (Time.now + movie.duration*60).strftime("%H:%M")

        expect(netflix.show(genre: 'Horror')).to eq "Now showing: The thing #{current_time} - #{movie_end_time}"
        expect(netflix.wallet).to eq 3.5
      end

      it 'fails when movie with filter not found' do
        netflix.stub(:filter) { [] }
        expect{netflix.show(genre: 'Comedy')}.to raise_error(BaseTheater::MovieNotFound)
      end
    end

    context 'no money on wallet' do
      it 'get error' do
        expect{netflix.show()}.to raise_error(Netflix::WithdrawError)
      end
    end
  end
end
