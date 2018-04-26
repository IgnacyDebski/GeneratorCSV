class HomeController < ApplicationController

  def home

  end

  def csv_fields
    authorize = Trello.authorize(current_user.trello_access_token, current_user.trello_secret_token)
    @organizations = JSON.parse(authorize.get("/members/#{current_user.trello_id}/organizations").body)
    if params[:organization].present?
      @boards = JSON.parse(authorize.get("/organizations/#{params[:organization]}/boards").body)
      if params[:board].present?
        @cards = JSON.parse(authorize.get("/boards/#{params[:board]}/cards?fields=name,shortUrl,dateLastActivity,id").body)
        filtered_cards = []
        @cards.each do |card|
          card_time = Time.at(card["id"][0..7].to_i(16)).to_date
          from = Date.strptime(params[:from], '%m/%d/%Y')
          to = Date.strptime(params[:to], '%m/%d/%Y')
          if from <= card_time && card_time <= to
            filtered_cards << card
          end
        end
      else
        @cards = []
      end
    else
      @boards = []
    end

    respond_to do |format|
      format.html
      format.csv { send_data Csv.generate(filtered_cards), filename: "#{Date.today}.csv" }
    end
  end

end
