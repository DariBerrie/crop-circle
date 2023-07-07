class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @weather = request_weather
  end

  private
  require "json"
  require "open-uri"

  # Here we're calling the Agromonitoring Current Weather Data API and returning its response to the dashboard action:
  # https://agromonitoring.com/api/current-weather 
  # This can definitely be improved. 
  
  def request_weather
    farm_lat = current_user.farm.latitude
    farm_lon = current_user.farm.longitude
    url = "https://api.agromonitoring.com/agro/1.0/weather?lat=#{farm_lat}&lon=#{farm_lon}&appid=#{ENV['AGROMONITORING_API_KEY']}"
    weather_serialized = URI.open(url).read
    weather = JSON.parse(weather_serialized)
  end
end
