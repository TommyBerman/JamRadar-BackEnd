class UserGenresController < ApplicationController
  before_action :set_user_genre, only: [:show, :update, :destroy]

  # GET /user_genres
  def index
    @user_genres = UserGenre.all

    render json: @user_genres
  end

  # GET /user_genres/1
  def show
    render json: @user_genre
  end

  # POST /user_genres
  def create
    @user_genre = UserGenre.new(user_genre_params)

    if @user_genre.save
      render json: @user_genre, status: :created, location: @user_genre
    else
      render json: @user_genre.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_genres/1
  def update
    if @user_genre.update(user_genre_params)
      render json: @user_genre
    else
      render json: @user_genre.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_genres/1
  def destroy
    @user_genre.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_genre
      @user_genre = UserGenre.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_genre_params
      params.require(:user_genre).permit(:user_id, :genre_id)
    end
end
