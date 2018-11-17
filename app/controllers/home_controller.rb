class HomeController < ApplicationController
  def index
  	@images = Image.recent_images
  end
end
