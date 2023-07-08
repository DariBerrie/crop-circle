class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @weather_week = format_weather
  end

  private

  # Here we're calling the Agromonitoring Current Weather Data API and returning its response to the dashboard action:
  # https://agromonitoring.com/api/current-weather 
  # This can definitely be improved. 
  require "json"
  require "open-uri"
  require "date"

  def request_weather
    lat = current_user.farm.latitude
    lon = current_user.farm.longitude
    now = DateTime.now
    url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/#{lat},#{lon}/today/next4days?key=#{ENV['VC_API_KEY']}&include=current"
    weather_serialized = URI.open(url).read
    weather = JSON.parse(weather_serialized)
  end

  def format_weather
    weather = request_weather
    weather_week = []
    weather["days"].each do |day|
      weather_hash = {
        datetime: Date.parse(day["datetime"]),
        weekday: Date.parse(day["datetime"]).strftime('%A'),
        temp: day["temp"],
        sunrise: day["sunrise"],
        sunset: day["sunset"],
        conditions: day["conditions"],
        precip_prob: day["precipprob"],
        description: day["description"],
        icon: day["icon"]
        }
        weather_week << weather_hash
    end
    weather_week
  end
end
