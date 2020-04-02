class UserInstrumentsController < ApplicationController
  before_action :set_user_instrument, only: [:show, :update, :destroy]

  # GET /user_instruments
  def index
    @user_instruments = UserInstrument.all

    render json: @user_instruments
  end

  # GET /user_instruments/1
  def show
    render json: @user_instrument
  end

  # POST /user_instruments
  def create
    @user_instrument = UserInstrument.new(user_instrument_params)

    if @user_instrument.save
      render json: @user_instrument, status: :created, location: @user_instrument
    else
      render json: @user_instrument.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_instruments/1
  def update
    if @user_instrument.update(user_instrument_params)
      render json: @user_instrument
    else
      render json: @user_instrument.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_instruments/1
  def destroy
    @user_instrument.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_instrument
      @user_instrument = UserInstrument.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_instrument_params
      params.require(:user_instrument).permit(:user_id, :instrument_id)
    end
end
