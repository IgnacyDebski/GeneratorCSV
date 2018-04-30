class HomeController < ApplicationController

  def home

  end

  def csv_fields
    @csv = Csv.new
    authorize = Trello.authorize(current_user.trello_access_token, current_user.trello_secret_token)
    @organizations = JSON.parse(authorize.get("/members/#{current_user.trello_id}/organizations").body)
    if params[:organization].present?
      @boards = JSON.parse(authorize.get("/organizations/#{params[:organization]}/boards").body)
      if params[:board].present?
        @cards = JSON.parse(authorize.get("/boards/#{params[:board]}/cards?fields=name,shortUrl,dateLastActivity,id").body)
        filtered_cards = filter_by_days(@cards, params[:from], params[:to])
      else
        @cards = []
        filtered_cards = []
      end
    else
      @boards = []
    end
    @csv = Csv.new(params[:from], params[:to], params[:organization], params[:board])
    if params[:format] == "csv" && @csv.valid?
      respond_to do |format|
        format.csv { send_data Csv.generate(filtered_cards), filename: "#{Date.today}.csv" }
      end
    else
      render "csv_fields.html.erb"
    end
  end

  private

  def filter_by_days(cards, from, to)
    filtered_cards = []
    cards.each do |card|
      card_time = Time.at(card["id"][0..7].to_i(16)).to_date
      date_from = Date.strptime(from, '%m/%d/%Y')
      date_to = Date.strptime(to, '%m/%d/%Y')

      filtered_cards << card if date_from <= card_time && card_time <= date_to
    end
    filtered_cards
  end

end
