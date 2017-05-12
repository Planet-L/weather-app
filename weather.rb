require 'barometer'
require 'rubygems'
require 'twilio-ruby'

account_sid = "ACb9a15db12c092eb271e3148d654d1f40"
auth_token = "9752de124e648bc110a4c0e665168e75"

@client = Twilio::REST::Client.new "ACb9a15db12c092eb271e3148d654d1f40",
"9752de124e648bc110a4c0e665168e75"

def get_user_location_weather(user_location)
  Barometer.new(user_location).measure
end

puts 'Please enter your zip code.'
user_location = gets.chomp


weather = get_user_location_weather('47408')
tomorrow = Time.now.strftime('%d').to_i + 1

weather.forecast.each do |forecast|
  day = forecast.starts_at.day

if day == tomorrow
  dayName = 'Tomorrow'
else
  dayName = forecast.starts_at.strftime('%A')
end

puts dayName + ' is going to be ' + forecast.icon + ' with a low of ' + forecast.low.f.to_s + ' and a high of ' + forecast.high.f.to_s + '.'
end

message = @client.account.messages.create(
  :from => "+18122134451",
  :to => "+18124303086",
  :body => "The current temperature is #{weather.current.temperature.f}."
)

puts message.to
