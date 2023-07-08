require "nokogiri"
require "open-uri"

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @weather_week = format_weather
    @soil_data = request_soil_temperature
    @wheat_price = request_price(1)
    @corn_price = request_price(17)
    @tasks_done = Task.where(workStatus: "done")
    @tasks_ongoing = Task.where(workStatus: "planned", startDate: Date.today..Date.today + 7)
    @tasks_planned = Task.where(workStatus: "planned", startDate: Date.today + 7..Date.today + 90)
    @articles = Article.all
    @peach_crop_data = [
      { name: "My 2023", data: {"6/6" => 24, "13/6" => 34, "21/6" => 42, "27/6" => 46, "5/7" => 50, "11/7" => nil, "18/7" => nil, "25/7" => nil, "1/8" => nil, "8/8" => nil  }},
      { name: "2022", data: {"6/6" => 27, "13/6" => 40, "21/6" => 46, "27/6" => 55, "5/7" => 65, "11/7" => 77, "18/7" => 85, "25/7" => 90, "1/8" => 93, "8/8" => 96 }}, 
      { name: "2023", data: {"6/6" => 27, "13/6" => 43, "21/6" => 51 , "27/6" => 60, "5/7" => 63, "11/7" => 77, "18/7" => 82, "25/7" => 87, "1/8" => 93, "8/8" => 96 }}
    ]
    @catnip_crop_data = [
      { name: "My 2023", data: { "6/6" => 30, "13/6" => 35, "21/6" => 35, "27/6" => 45, "5/7" => 46, "11/7" => nil, "18/7" => nil, "25/7" => nil }},
      { name: "2022", data: {"6/6" => 40, "13/6" => 40, "21/6" => 45, "27/6" => 50, "5/7" => 50, "11/7" => 52, "18/7" => 55, "25/7" => 65, "1/8" => 70, "8/8" => 72 }}, 
      { name: "2023", data: {"6/6" => 40, "13/6" => 42, "21/6" => 46, "27/6" => 50, "5/7" => 52, "11/7" => 54, "18/7" => 56, "25/7" => 65, "1/8" => 70, "8/8" => 73 }}
    ]
    @corn_crop_data = [
      { name: "My 2023", data: { "6/6" => 50, "13/6" => 55, "21/6" => 57, "27/6" => 60, "5/7" => 64, "11/7" => nil, "18/7" => nil, "25/7" => nil }},
      { name: "2022", data: {"6/6" => 48, "13/6" => 50, "21/6" => 55, "27/6" => 59, "5/7" => 64, "11/7" => 67, "18/7" => 80, "25/7" => 88, "1/8" => 90, "8/8" => 90 }}, 
      { name: "2023", data: {"6/6" => 48, "13/6" => 52, "21/6" => 55 , "27/6" => 60, "5/7" => 62, "11/7" => 63, "18/7" => 75, "25/7" => 80 }}
    ]
  end

  private

  # Here we're calling the Agromonitoring Current Weather Data API and returning its response to the dashboard action:
  # https://agromonitoring.com/api/current-weather
  # This can definitely be improved.
  require "json"
  require "date"

  def request_weather
    lat = current_user.farm.latitude
    lon = current_user.farm.longitude
    now = DateTime.now
    url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/#{lat},#{lon}/today/next4days?unitGroup=metric&key=#{ENV['VC_API_KEY']}&include=current"
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

  def request_soil_temperature
    lat = current_user.farm.latitude
    lon = current_user.farm.longitude
    url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/#{lat},#{lon}/today?unitGroup=metric&key=#{ENV['VC_API_KEY']}&include=current&elements=soiltemp01,soiltemp04,soiltemp10,soilmoisture01,soilmoisture04,soilmoisture10,et0"
    soil_data_serialized = URI.open(url).read
    soil_data = JSON.parse(soil_data_serialized)
    soil_data = soil_data["days"][0]
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
