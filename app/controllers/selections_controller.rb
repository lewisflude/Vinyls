require './lib/last_fm'
require './lib/album_selection_services'
class SelectionsController < ApplicationController

  def index
    @selections = Selection.all(order: "created_at DESC", limit: 50)
    @selection = Selection.new
  end

  def new
    @selection = Selection.new
  end

  def create
    artist = params[:artist]
    title = params[:title]
    begin
      @selection = AlbumSelectionServices.select_album(current_user, artist, title)
      redirect_to current_user, flash: { notice: "Selection added" }
    rescue AlbumNotFoundException
      redirect_to new_selection_path, :flash => { error: "Album not found" }
    end
  end

  def show # GET /album/[:id]
    @selection = Selection.find(params[:id])
  end

  def edit 
    @selection = Selection.find(params[:id])
  end

  def update
    @selection = Selection.find(params[:id])
    @selection.update_attributes(description: params[:description])
    if @selection.update_attributes(params[:selection])
      redirect_to @selection, notice: 'Selection was successfully updated.'
    else
      render :edit, notice: 'Selection was not updated.'
    end
  end

  def destroy
    @selection = Selection.find(params[:id])
    @selection.destroy

    redirect_to current_user, flash: { notice: "Selection removed" }
  end

end
