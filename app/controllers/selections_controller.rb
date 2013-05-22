require './lib/last_fm'
require './lib/album_selection_services'
class SelectionsController < ApplicationController

  load_and_authorize_resource

  def index
    @selections = Selection.all(order: "created_at DESC", limit: 50)
  end

  def new
  end

  def create
    artist = params[:artist]
    title = params[:title]
    begin
      @selection = AlbumSelectionServices.select_album(current_user, artist, title)
      redirect_to current_user, flash: { notice: "Selection added" }
    rescue AlbumNotFoundException
      redirect_to new_selection_path, :flash => { error: "Album not found on Last.fm." }
    rescue AlbumArtNotFoundException
      redirect_to new_selection_path, :flash => { error: "Album art not found on Last.fm" }
    end
  end

  def show # GET /album/[:id]
  end

  def edit 
    authorize! :update, @selection
  end

  def update
    @selection.update_attributes(description: params[:description])
    if @selection.update_attributes(params[:selection])
      redirect_to @selection, notice: 'Selection was successfully updated.'
    else
      render :edit, notice: 'Selection was not updated.'
    end
  end

  def destroy
    @selection.destroy

    redirect_to current_user, flash: { notice: "Selection removed" }
  end

end
