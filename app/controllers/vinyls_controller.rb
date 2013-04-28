require './lib/last_fm'
class VinylsController < ApplicationController

  def index # GET /vinyls
    @vinyls = Vinyl.all(order: "created_at DESC", limit: 50)
    @vinyl = Vinyl.new
  end

  def new # GET /vinyls/new
    @vinyl = Vinyl.new
  end

  def create # POST /vinyls
    @vinyl = current_user.vinyls.build(params[:vinyl]) 

    # Fetch album_art from Last.fm

    lastfm = LastFm.new

    @vinyl.album_art = open(lastfm.fetch_album_art(@vinyl.title))

    @vinyl.genre = lastfm.fetch_album_genre(@vinyl.artist, @vinyl.title)

    if @vinyl.save
      redirect_to vinyls_path, notice: 'Release was successfully logged.'
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
