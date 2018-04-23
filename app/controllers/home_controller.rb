class HomeController < ApplicationController

  def home

  end

  def csv_fields
    authorize = Trello.authorize(current_user.trello_access_token, current_user.trello_secret_token)
    @result = JSON.parse(authorize.get("/members/#{current_user.trello_id}/organizations").body)
  end

end
