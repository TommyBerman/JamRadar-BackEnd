require 'byebug'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user ,except: :password_digest , include: [:genres, :instruments]
  end

  # POST /users
  def create
    @user = User.new({first_name: params[:firstN], last_name: params[:lastN], password_digest: BCrypt::Password.create(params[:password]),
       email: params[:email], age: params[:age],
        gender: params[:gender],
         hometown: params[:hometown],
         level: params[:level],
         goal: params[:goal], bio: params[:bio],
         })
    @genres = Genre.find(params[:genres])
    @instruments = Instrument.find(params[:instruments])
    
    

    if @user.save
      @user.genres << @genres
      @user.instruments << @instruments
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  def sign_in
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      render json: { email: user.email,
         token: generate_token(id: user.id),

       }
    else
      render json: { error: "email or Password is invalid "}
    end
  end

  def validate
    if get_user
      render json: { email: get_user.email, token: generate_token(id: get_user.id)}
    else
      render json: { error: "You are not authorized" }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :password_digest, :email, :age, :gender, :hometown, :level, :goal, :purpose)
    end
end
