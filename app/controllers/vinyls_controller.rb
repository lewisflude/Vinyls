class VinylsController < ApplicationController
  
  def index # GET /vinyls
    @vinyls = Vinyl.all
    session[:greeting] = "Hey Lewis"
  end

  def new # GET /vinyls/new
    @vinyl = Vinyl.new
  end

  def create # POST /vinyls
    @vinyl = Vinyl.new(params[:vinyl])
    if @vinyl.save
      redirect_to @vinyl, notice: 'Vinyl was successfully logged.'
    else
      render 'new'
    end
  end

  def show # GET /vinyl/[:id]
    @vinyl = Vinyl.find(params[:id])
  end

end
