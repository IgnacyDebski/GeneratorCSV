class HomeController < ApplicationController

  def home

  end

  def csv_fields
    authorize = Trello.authorize(current_user.trello_access_token, current_user.trello_secret_token)
    @organizations = JSON.parse(authorize.get("/members/#{current_user.trello_id}/organizations").body)
    @boards = JSON.parse(authorize.get("/organizations/56372edfc3ac4cb0631bfc0a/boards").body)
    #logger.info @boards.inspect

    def month_calendar

    end
  end



end
