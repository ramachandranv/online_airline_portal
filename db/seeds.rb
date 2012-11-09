# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "We have started seeding the data to the database. Please be patient."
file = File.open(Rails.root.join("tmp", "airports_list"), "r")
airports = []
file.each do |line|
  unless (line == "\n")
    city_name = line.to_s.slice(6, line.length).chomp
    code = line.to_s.slice(0,3)
    airports << {name: "#{city_name} (#{code})"}
  end
end

puts "Started seeding cities"
cities = City.create(airports)

file1 = File.open(Rails.root.join("tmp", "airlines_list"), "r")
airlines = []
file1.each do |airport|
  airlines << {name: "#{airport.chomp}"}
end

puts "Started seeding airlines"
airlines = Airline.create(airlines)

puts "Done!"
