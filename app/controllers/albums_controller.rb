require './lib/last_fm'
class AlbumsController < ApplicationController

  def index # GET /albums
    @albums = Album.all(order: "created_at DESC", limit: 50)
    @album = Album.new
  end

  def new # GET /albums/new
    @album = Album.new
  end

  def create # POST /albums
    @album = current_user.albums.build(params[:album]) 

    # Fetch album_art from Last.fm

    lastfm = LastFm.new

    @album.album_art = open(lastfm.fetch_album_art(@album.artist, @album.title))

    if @album.save
      redirect_to albums_path, notice: 'Release was successfully logged.'
    else
      render :new
    end
  end

  def show # GET /album/[:id]
    @album = Album.find(params[:id])
  end

  def edit 
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    @album.user_id = current_user.id
    if @album.update_attributes(params[:album])
      redirect_to @album, notice: 'album was successfully updated.'
    else
      render :edit, notice: 'album was not updated.'
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    redirect_to action: :index
  end

end
