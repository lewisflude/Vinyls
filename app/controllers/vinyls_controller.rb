class VinylsController < ApplicationController
  
  def index # GET /vinyls
    @vinyls = Vinyl.all

  end

  def new # GET /vinyls/new
    @vinyl = Vinyl.new
  end

  def create # POST /vinyls
    @vinyl = Vinyl.new(params[:vinyl])
    @vinyl.user_id = current_user.id
    if @vinyl.save
      redirect_to @vinyl, notice: 'Vinyl was successfully logged.'
    else
      render 'new'
    end
  end

  def show # GET /vinyl/[:id]
    @vinyl = Vinyl.find(params[:id])
  end

  def edit 
    @vinyl = Vinyl.find(params[:id])
  end

  def update
    @Vinyl = Vinyl.find(params[:id])
    if @Vinyl.update_attributes(vinyl: params[:vinyl])
      redirect_to @Vinyl
    else
      render :edit
    end
  end

end
