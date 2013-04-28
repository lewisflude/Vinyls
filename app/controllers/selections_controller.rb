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
    @selection = AlbumSelectionServices.select_album(current_user, artist, title)

    if @selection.save
      redirect_to selections_path, notice: 'Release was successfully logged.'
    else
      render :new
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

    redirect_to action: :index
  end

end
