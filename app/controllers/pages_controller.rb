require "nokogiri"
require "open-uri"


class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @weather_week = format_weather
    @wheat_price = request_price(1)
    @corn_price = request_price(17)
    @data = [
      { name: "My 2023", data: { "6/6" => 24, "13/6" => 34, "21/6" => 42, "27/6" => 46, "5/7" => 50, "11/7" => nil, "18/7" => nil, "25/7" => nil }},
      { name: "2022", data: {"6/6" => 27, "13/6" => 40, "21/6" => 46, "27/6" => 55, "5/7" => 65, "11/7" => 77, "18/7" => 85, "25/7" => 90 }}, 
      { name: "2023", data: {"6/6" => 27, "13/6" => 43, "21/6" => 51 , "27/6" => 60, "5/7" => 63, "11/7" => 77, "18/7" => 82, "25/7" => 87 }}
    ]
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

  def request_price(number)
    trading_url = "https://tradingeconomics.com/commodity/wheat"
    trading_file = URI.open(trading_url)
    traiding_doc = Nokogiri::HTML.parse(trading_file)
    price = traiding_doc.search('.table-minimize #p')[number].text.strip
    day = traiding_doc.search('.table-minimize #pch')[number].text.strip
    price_data = []
    price_data << price
    price_data << day
    price_data
  end

end
