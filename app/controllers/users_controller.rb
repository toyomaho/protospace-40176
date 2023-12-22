class UsersController < ApplicationController
  before_action :configure_permitted_parameters, only: :create

  def create
    @user = User.new(user_params)
    @user.save
  end
  
  def edit
  end

  def show
    @user = User.find(params[:id])
    @prototypes = @user.prototypes
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_email, :user_password, :user_password_confirmation, :user_name, :user_profile, :user_occupation, :user_position])
  end

  def user_params
    params.require(:user).permit(:user_email, :user_password, :user_password_confirmation, :user_name, :user_profile, :user_occupation, :user_position)
  end

end
