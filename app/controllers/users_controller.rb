class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create, :login]
  
  def login
    # debugger
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      token = jwt_encode(user_id: user.id)
      render json: { message: "Logged In Successfully..", token: token }
    else
      render json: { error: "Please Check your Email And Password....." }
    end
  end

  def index
    # debugger
    @users = User.all
    render json: @users
  end

  def show
    byebug
    render json: @current_user
  end
  
  def create
    debugger
    user = User.new(user_params)
    if user.save  
      # UserMailer.with(user: @user).welcome_email.deliver_now  
      render json: user, status: 201
    else
      render json: user.errors.full_messages,status: 422
    end
  end
  
  def update
    # debugger
    if @current_user.update(user_params)
      render json: @current_user,status: 200
    else
      debugger
      render json: @current_user.errors.full_messages,status: 422
    end
  end
  
  def destroy
    if @current_user.destroy
      render json: { message: 'User deleted successfully' }
    else
      render json: @current_user.errors.full_messages, status: 400
    end
  end
  
  private
  def user_params
    params.permit(:user_name, :email, :password, :type)
  end
end
