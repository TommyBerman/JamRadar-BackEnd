class UserQuestionDetailsController < ApplicationController

  # GET /user_question_details
  def index
    @user_question_detail = UserQuestionDetail.find_by(user_id: get_user().id)

    render json: @user_question_detail
  end


  # POST /user_question_details
  def create
    @user_question_detail = UserQuestionDetail.find_by(user_id: get_user().id)
    if !@user_question_detail
    @user_question_detail = UserQuestionDetail.new(user_question_detail_params)
    @user_question_detail.user_id = get_user().id
    else
      @user_question_detail.attributes = user_question_detail_params
    end
  
    if @user_question_detail.save
      render json: @user_question_detail, status: :created, location: @user_question_detail
    else
      render json: @user_question_detail.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_question_details/1
  def update
    if @user_question_detail.update(user_question_detail_params)
      render json: @user_question_detail
    else
      render json: @user_question_detail.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_question_details/1
  def destroy
    @user_question_detail = UserQuestionDetail.find_by(user_id: get_user().id)
    @user_question_detail.destroy
  end

  private


  # Only allow a trusted parameter "white list" through.
  def user_question_detail_params
    params.require(:user_question_detail).permit(:match_instrument, :match_genre, :match_level, :match_goal, :min_age, :max_age, :hometown)
  end
end
