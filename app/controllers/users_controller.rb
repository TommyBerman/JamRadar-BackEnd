require 'byebug'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @user = User.find(get_user().id)

    render json: @user ,except: :password_digest , include: [:genres, :instruments]
  end

  # GET /users/1
  def show
    render json: @user ,except: :password_digest , include: [:genres, :instruments]
  end

def candidates
  @loggedUserPreferences = UserQuestionDetail.find_by(user_id: get_user().id)
  # byebug
  @searchCriteria = {
    user_instruments: {
      instrument_id: @loggedUserPreferences.match_instrument.split(',')
    },
    user_genres: {
      genre_id: @loggedUserPreferences.match_genre.split(',')
    },
    level: @loggedUserPreferences.match_level,
    goal: @loggedUserPreferences.match_goal,
    age: @loggedUserPreferences.min_age..@loggedUserPreferences.max_age
  }
  stage = 0
  
  loop do
    
    case stage
    when 1
      @searchCriteria = @searchCriteria.except(:level)
    when 2
      @searchCriteria = @searchCriteria.except(:goal)
    when 3
      @searchCriteria = @searchCriteria.except(:age)
    else
    end 

 stage+=1
  
    # byebug
  @candidates = User.includes(:instruments).includes(:genres).where(@searchCriteria).where.not(id: [get_user().id, get_user().likes.map {|like| like.liked_user}].flatten())
  
  #   byebug

  break if @candidates.length != 0 || stage >= 4
  end

  render json: @candidates ,except: :password_digest , include: [:genres, :instruments]
end

def matches
  @user = get_user()
  @likedUserIds = @user.likes.map {|like| like.liked_user}
  @matches = User.includes(:likes).where({likes: {liked_user: @user.id}, id: @likedUserIds})

  render json: @matches ,except: :password_digest , include: [:genres, :instruments]
end


  # POST /users
  def create
    userParams = {
      first_name: params[:firstN], last_name: params[:lastN], password_digest: BCrypt::Password.create(params[:password]),
      email: params[:email], age: params[:age],
       gender: params[:gender],
        hometown: params[:hometown],
        level: params[:level],
        goal: params[:goal], bio: params[:bio],
        image: params[:image]
    }
    if !get_user()
      @user = User.new(userParams)
      
    else 
      get_user().attributes =  userParams
    end
      @genres = Genre.find(params[:genres])
      @instruments = Instrument.find(params[:instruments])

    if @user.save
      @user.genres << @genres
      @user.instruments << @instruments
      render json: {user: @user, token: generate_token({id: @user.id })} ,except: :password_digest , include: [:genres, :instruments]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    
    userParams = {
      first_name: params[:first_name], last_name: params[:last_name], password_digest: BCrypt::Password.create(params[:password]),
      email: params[:email], age: params[:age],
      gender: params[:gender],
      hometown: params[:hometown],
      level: params[:level],
      goal: params[:goal], bio: params[:bio],
      image: params[:image]
    } 

    @user = get_user()
    @user.attributes =  userParams
    @genres = Genre.find(params[:genres])
    @instruments = Instrument.find(params[:instruments])

    if @user.update(userParams)
      @user.genres = @genres
      @user.instruments = @instruments
      render json: {user: @user, token: generate_token({id: @user.id })} ,except: :password_digest , include: [:genres, :instruments]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def like
    @user = get_user()
    @like = Like.new(user_id: @user.id, liked_user: params[:liked_user])

    if @like.save
      render json: {}
    else
      render json: @like.errors, status: :conflict
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(get_user().id)
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
