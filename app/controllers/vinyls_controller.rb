class VinylsController < ApplicationController
  def index
    @vinyls = Vinyl.all
  end

  def show
    @vinyl = Vinyl.find(params[:id])
  end
  
  def new
    @vinyl = Vinyl.new 
  end

  def create 
    @vinyl = Vinyl.new(params[:vinyl])
    if @vinyl.save
      redirect_to @vinyl, notice: 'Vinyl was successfully logged.'
    else
      render 'new'
    end
  end
end
