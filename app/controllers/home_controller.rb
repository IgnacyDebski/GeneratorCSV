class HomeController < ApplicationController

  def home

  end

  def csv_fields
    authorize = Trello.authorize(current_user.trello_access_token, current_user.trello_secret_token)
    @organizations = JSON.parse(authorize.get("/members/#{current_user.trello_id}/organizations").body)
    if params[:organization]
      @boards = JSON.parse(authorize.get("/organizations/#{params[:organization]}/boards").body)
    else
      @boards = []
    end

  end

  def generate_csv
    authorize = Trello.authorize(current_user.trello_access_token, current_user.trello_secret_token)
    logger.info params[:board]
    @cards = JSON.parse(authorize.get("/boards/#{params[:board]}/cards").body)
    logger.info @cards
    Csv.new()
    flash.now[:success] = "Udało się wygenerować plik csv"
  end
end
