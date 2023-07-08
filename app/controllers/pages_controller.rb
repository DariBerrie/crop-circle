require "nokogiri"
require "open-uri"


class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @weather = request_weather
    @wheat_price = request_price(1)
    @corn_price = request_price(17)
    @tasks_done = Task.where(workStatus: "done")
    @tasks_ongoing = Task.where(workStatus: "planned", startDate: Date.today..Date.today + 7)
    @tasks_planned = Task.where(workStatus: "planned", startDate: Date.today + 7..Date.today + 90)
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
