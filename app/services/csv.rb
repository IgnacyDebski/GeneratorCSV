class Csv
  attr_accessor :from, :to, :organization, :board, :errors

  def initialize(from = nil, to = nil, organization = nil, board = nil)
    @from = from
    @to = to
    @organization = organization
    @board = board
    @errors = []
  end

  def required_organization
    @errors << "Pole organizacja musi zostać wybrane" if @organization.blank?
  end

  def required_board
    @errors << "Pole tablica musi zostać wybrane" if @board.blank?
  end

  def required_date_from
    @errors << "Data od musi zostać wybrana" if @from.blank?
  end

  def required_date_to
    @errors << "Data do musi zostać wybrana" if @to.blank?
  end

  def check_date
    if @from && @to
      if Date.strptime(@from, '%m/%d/%Y') > Date.strptime(@to, '%m/%d/%Y')
        @errors << "Data początkowa nie może być większa od końcowej"
      end
    end
  end

  def valid?
    self.required_organization
    self.required_board
    self.required_date_from
    self.required_date_to
    self.check_date
    @errors.empty? ? true : false
  end

  def self.generate(cards)
    CSV.generate do |csv|
      csv << [ Date.today ]
      csv << ["data założenia tasku", "data realizacji tasku", "okres rozliczeniowy (rok+mc)", "name", "hyperlink"]
      cards.each do |card|
        csv << [ Time.at(card["id"][0..7].to_i(16)).to_datetime.strftime("%Y-%m-%d"),
                 card["dateLastActivity"].to_datetime.strftime("%Y-%m-%d"),
                 Time.at(card["id"][0..7].to_i(16)).to_datetime.strftime("%Y/%m"),
                 card["name"].truncate(50),
                 card["shortUrl"]
        ]
      end
    end
  end
end
