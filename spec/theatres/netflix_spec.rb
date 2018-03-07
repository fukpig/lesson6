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
    subject(:show) { netflix.show(params) }
    context 'when enough money' do
      let(:params) { }
      before { netflix.pay(5) }
      it { is_expected.to include "Now showing" }
    end
    context 'when enough money and filter' do
      let(:params) { {genre: 'Horror'} }
      before { netflix.pay(5) }
      it { is_expected.to include "Now showing" }
    end
    context 'when enough money and movie not found' do
      let(:params) { {genre: 'Tragedy'} }
      before { netflix.pay(5) }
      it { expect { show }.to raise_error(BaseTheater::MovieNotFound) }
    end
    context 'when not enough money' do
      let(:params) { {genre: 'Horror'} }
      it { expect { show }.to raise_error(Netflix::WithdrawError) }
    end
  end

end
