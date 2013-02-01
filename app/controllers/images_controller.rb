class ImagesController < ApplicationController
  def index
    @images = Image.all
    @image = Image.new
  end

  def create
    @image = Image.new(params[:image])

    if @image.save
      redirect_to images_url, notice: 'Image was successfully created.'
    else
      redirect_to images_url, error: 'Error'
    end
  end
end
