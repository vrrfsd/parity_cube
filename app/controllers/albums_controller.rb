class AlbumsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  # GET /albums
  # GET /albums.json
  def index
    @albums = current_user.albums
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @images = @album.images.all
  end

  # GET /albums/new
  def new
    @album = Album.new
    @album.images.build
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(album_params)
    @album.user = current_user
    respond_to do |format|
      if @album.save
        if params[:images]
          params[:images]['pic'].each do |a|
            @album.images.create(:pic => a, user_id: current_user.id) unless @album.images.size > 24
          end
        end
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        params[:images]['pic'].each do |a|
          @album.images.create(:pic => a, user_id: current_user.id) unless @album.images.size > 24
        end        
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
      unless @album.user == current_user
        respond_to do |format|
          format.html { redirect_to albums_url, notice: 'You are not autherized to access this Album' }
          format.json { head :no_content }
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:user_id, :name, images_attributes: [:id, :post_id, :pic])
    end
end
