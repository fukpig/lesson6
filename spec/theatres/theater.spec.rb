require 'spec_helper'
require 'rspec/its'
require 'timecop'

require './theatres/theater.rb'

describe Theater do
  let(:file) { "spec_movies.txt" }
  let(:theater) { Theater.new(file) }

  describe '#when?' do
    it 'find movie' do
      expect(theater.when?("The Shining")).to eq :evening
    end
    it 'get error when movie cant be find in text file' do
      expect{theater.when?("La la land")}.to raise_error(BaseTheater::MovieNotFound)
    end
    it 'get error when movie not in schedule' do
      expect{theater.when?("Scream")}.to raise_error(BaseTheater::MovieNotFound)
    end
  end

  describe '#show' do
    before { Timecop.freeze(Time.local(2018, 3, 12, 13, 0, 0)) }

    context "check filter works properly" do
      let (:movie) { double("ClassicMovie", :duration => 100, :title => "The thing") }
        it 'return period ancient filter' do
          allow(theater).to receive(:filter).and_return([movie])
          theater.show("10:00")
          expect(theater).to have_received(:filter).with({:period=>:ancient})
        end
    end

    context "check morning classic movie" do
      let (:movie) { double("ClassicMovie", :duration => 100, :title => "The thing") }
      it "show film from morning period" do
        allow(theater).to receive(:filter).and_return([movie])
        expect{theater.show("10:00")}.to output("Now showing: The thing 13:00 - 14:40\n").to_stdout
      end
    end

    context "check day adventure or comedy movie" do
      context "check filter works properly" do
        let (:movie) { double("ModernMovie", :duration => 110, :title => "Indiana Jones", :genre => ["Adventure"]) }
          it 'return adventure or comedy regexp' do
            allow(theater).to receive(:filter).and_return([movie])
            theater.show("13:00")
            expect(theater).to have_received(:filter).with({:genre=>/Comedy|Adventure/})
          end
      end

      context "adventure movie" do
        let (:movie) { double("ModernMovie", :duration => 110, :title => "Indiana Jones", :genre => ["Adventure"]) }
          it 'when adventure film' do
            allow(theater).to receive(:filter).and_return([movie])
            expect{theater.show("13:00")}.to output("Now showing: Indiana Jones 13:00 - 14:50\n").to_stdout
          end
      end

      context "comedy movie" do
        let (:movie) { double("ModernMovie", :duration => 110, :title => "Dumb and dumber", :genre => ["Comedy"]) }
          it 'when adventure film' do
            allow(theater).to receive(:filter).and_return([movie])
            expect{theater.show("13:00")}.to output("Now showing: Dumb and dumber 13:00 - 14:50\n").to_stdout
          end
      end
    end


    context "check evening horror or drama movie" do
      context "check filter works properly" do
        let (:movie) { double("ModernMovie", :duration => 110, :title => "Alien", :genre => ["Horror"]) }
          it 'return horror or drama regexp' do
            allow(theater).to receive(:filter).and_return([movie])
            theater.show("21:00")
            expect(theater).to have_received(:filter).with({:genre=>/Horror|Drama/})
          end
      end


      context "adventure movie" do
        let (:movie) { double("ModernMovie", :duration => 110, :title => "Alien", :genre => ["Horror"]) }
          it 'when horror film' do
            allow(theater).to receive(:filter).and_return([movie])
            expect{theater.show("21:00")}.to output("Now showing: Alien 13:00 - 14:50\n").to_stdout
          end
      end

      context "drama movie" do
        let (:movie) { double("ModernMovie", :duration => 110, :title => "Bridgit jones", :genre => ["Drama"]) }
          it 'when drama film' do
            allow(theater).to receive(:filter).and_return([movie])
            expect{theater.show("21:00")}.to output("Now showing: Bridgit jones 13:00 - 14:50\n").to_stdout 
          end
      end
    end

    context "get error with invalid time" do
      it "return invalid time period" do
        expect{theater.show("07:00")}.to raise_error(Theater::InvalidTimePeriod)
      end
    end
  end
end
