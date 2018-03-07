require './theatres/netflix.rb'
require './theatres/theater.rb'

netflix = Netflix.new("movies.txt")
puts netflix.pay(20)
puts netflix.how_much?('The Terminator')

puts netflix.show(genre: 'Horror', period: :modern)
puts netflix.show()
puts netflix.wallet

puts "========"
theater = Theater.new("movies.txt")
puts theater.when?('Psycho')

puts theater.show("10:30")
puts theater.show("13:00")
