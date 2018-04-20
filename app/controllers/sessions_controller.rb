class SessionsController < ActionController::Base

  def new
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Logowanie się powiodło, witaj! #{@user.name}"
      redirect_to root_path
    else
      flash[:danger] = "Logowanie się niepowiodło, spróbuj jeszcze raz."
      render "registration_form"
    end
  end

  def registration_form

  end

  def registration
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Rejestracja się powiodła #{@user.name}"
      redirect_to root_path
    else
      flash[:danger] = "Rejestracja się niepowiodła #{@user.name}"
      render "registration_form"
    end
  end

  def create

  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
