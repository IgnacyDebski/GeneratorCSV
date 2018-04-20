class RegistrationController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Rejestracja się powiodła #{@user.name}"
      session[:user_id] = @user.id
      redirect_to root_path

    else
      flash[:danger] = "Rejestracja się niepowiodła #{@user.name}"
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
