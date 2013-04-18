class VinylsController < ApplicationController
  
  def index # GET /vinyls
    @vinyls = Vinyl.all(order: "created_at DESC")
  end

  def new # GET /vinyls/new
    @vinyl = Vinyl.new
  end

  def create # POST /vinyls
    @vinyl = current_user.vinyls.build(params[:vinyl]) 
    
    # @vinyl = Vinyl.new(params[:vinyl])
    # @vinyl.user_id = current_user.id

    if @vinyl.save
      redirect_to @vinyl, notice: 'Release was successfully logged.'
    else
      render :new
    end
  end

  def show # GET /vinyl/[:id]
    @vinyl = Vinyl.find(params[:id])
  end

  def edit 
    @vinyl = Vinyl.find(params[:id])
  end

  def update
    @vinyl = Vinyl.find(params[:id])
    @vinyl.user_id = current_user.id
    if @vinyl.update_attributes(params[:vinyl])
      redirect_to @vinyl, notice: 'Vinyl was successfully updated.'
    else
      render :edit, notice: 'Vinyl was not updated.'
    end
  end

  def destroy
    @vinyl = Vinyl.find(params[:id])
    @vinyl.destroy

    redirect_to action: :index
  end

end
