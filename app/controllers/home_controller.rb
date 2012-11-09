class HomeController < ApplicationController
  def dashboard
  end

  def get_cities
    cities = City.where(['name like ?', "%#{params[:city]}%"])
    cities_array = []
    cities.each do |city|
      cities_array << city.name
    end
    render :json => cities_array
  end

  def get_airlines
    airlines = Airline.where(['name like ?', "%#{params[:airline]}%"])
    airlines_array = []
    airlines.each do |airline|
      airlines_array << airline.name
    end
    render :json => airlines_array
  end
end
