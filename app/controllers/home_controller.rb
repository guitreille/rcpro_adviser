

class HomeController < ApplicationController
  def index
    base_uri = 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY'
    response = HTTParty.get(base_uri)
    @response = JSON.parse(response.body) if response.code == 200
  end

  def about 
  end 

end
