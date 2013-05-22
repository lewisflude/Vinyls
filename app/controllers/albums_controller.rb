class AlbumsController < ApplicationController
  def new
    @album = Album.new
  end
end
