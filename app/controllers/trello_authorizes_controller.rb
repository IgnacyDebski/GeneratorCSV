class TrelloAuthorizesController < ApplicationController

  def index
    redirect_to Trello.set_callback(callback_trello_authorizes_url).authorize_url(name: 'CSV_Maker', scope: 'read,account', expiration: 'never')
  end

  def callback
     if params[:oauth_verifier].nil?
       redirect_to root_path
      return
     end
    connect = Trello.set_callback(callback_trello_authorizes_url)
    access_token  = connect.get_access_token(expires: :never, oauth_verifier: params[:oauth_verifier])
    result = JSON.parse(access_token.get('/members/me').body)
    user = User.find_by(trello_id: result["id"])
    if user
      session[:user_id] = user.id
      redirect_to csv_path
    else
      user = User.create(
          email: result["email"],
          trello_id: result["id"],
          trello_username: result["fullName"],
          trello_access_token: access_token.token,
          trello_secret_token: access_token.secret
      )
      session[:user_id] = user.id
      redirect_to csv_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Wylogowałeś się"
    redirect_to root_path
  end
end
