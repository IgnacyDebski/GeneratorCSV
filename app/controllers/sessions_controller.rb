class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Gratulacje, zalogowałeś się poprawnie"
      redirect_to root_path
    else
      flash.now[:danger] = "Coś jest nie tak z twoimi danymi logowania"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Wylogowałeś się"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:session).permit(:name, :email, :password)
  end

end
