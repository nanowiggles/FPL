require 'net/http'
require 'json'
require 'csv'

DOC = 'file.csv'
url = 'https://fantasy.premierleague.com/drf/bootstrap-static'
uri = URI(url)
response = Net::HTTP.get(uri)
obj = JSON.parse(response).to_h
CSV.open(DOC, "w") do |data|
  data << obj['elements'].first.keys
  obj['elements'].each do |player|
    data << player.values
  end
end

# obj['elements'].each do |player|
#   puts player.values.where(total_points == 0)
# end
points = []

obj['elements'].each do |point|
  points << point['total_points'] if point['total_points'] > 0
end

puts points.count
puts points.inject(0){|sum,x| sum + x }