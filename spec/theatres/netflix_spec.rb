require 'spec_helper'
require './theatres/netflix.rb'

describe Netflix do
  before :each do
    @netflix = Netflix.new("spec_movies.txt")
  end

  describe ".withdraw" do
    it "widthdraw 5 dollars" do
      @netflix.pay(5)
      @netflix.withdraw(5)
      expect(@netflix.wallet).to eq(0)
    end

    it "widthdraw raise error" do
      expect{@netflix.withdraw(5)}.to raise_error(Netflix::WithdrawError)
    end
  end

  describe ".check_money" do
    it "check 5 dollars raise error" do
      expect{@netflix.check_money(5)}.to raise_error(Netflix::WithdrawError)
    end
  end

  describe ".pay" do
    it "add 5 money to wallet" do
      @netflix.pay(5)
      expect(@netflix.wallet).to eq(5)
    end
  end

  describe ".how_much?" do
    it "check movie cost" do
      expect(@netflix.how_much?("The Shining")).to eq(3)
    end
  end

  describe ".show" do
    it "show" do
      @netflix.pay(5)
      expect(@netflix.show()).to include("Now showing:")
    end

    it "error" do
      @netflix.pay(5)
      expect{@netflix.show(genre: 'Spec genre')}.to raise_error(BaseTheater::MovieToShowNotFound)
    end
  end

end
