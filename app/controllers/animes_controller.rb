class AnimesController < ApplicationController
  before_action :set_anime, only: [:show, :edit, :update, :destroy]
  before_action :user_signed_in?, only: [:new, :edit, :update, :destroy]
  # GET /animes
  # GET /animes.json
  def index
    @animes = Anime.all
    @reivews = Review.all.order(:created_at => :desc)
    @top_airing_animes = Anime.select_top_airing
    @top_upcoming_animes = Anime.select_top_upcoming
  end

  # GET /animes/1
  # GET /animes/1.json
  def show
    @add = @anime.adds.includes(:user)
    @is_added = @anime.is_added(current_user)
    @review = Review.new
  end

  # GET /animes/new
  def new
    @anime = Anime.new
  end

  # GET /animes/1/edit
  def edit
  end

  # POST /animes
  # POST /animes.json
  def create
    @anime = Anime.new(anime_params)

    respond_to do |format|
      if @anime.save
        format.html { redirect_to @anime, notice: 'Anime was successfully created.' }
        format.json { render :show, status: :created, location: @anime }
      else
        format.html { render :new }
        format.json { render json: @anime.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /animes/1
  # PATCH/PUT /animes/1.json
  def update
    respond_to do |format|
      if @anime.update(anime_params)
        format.html { redirect_to @anime, notice: 'Anime was successfully updated.' }
        format.json { render :show, status: :ok, location: @anime }
      else
        format.html { render :edit }
        format.json { render json: @anime.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /animes/1
  # DELETE /animes/1.json
  def destroy
    @anime.destroy
    respond_to do |format|
      format.html { redirect_to animes_url, notice: 'Anime was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def anime_list
    # Query DB in here
    @animes = Anime.all
  end

  def anime_airing_rank_list
    # Query DB in here
    @animes = Anime.select_top_airing
  end

  def anime_upcoming_rank_list
    # Query DB in here
    @animes = Anime.select_top_upcoming
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_anime
      @anime = Anime.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def anime_params
      params.require(:anime).permit(:name, :kind, :producer, :licencer, :episode, :premiered, :studio, :source, :genre, :duration, :picture, :rating, :score, :description)
    end
end
