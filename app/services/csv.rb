class Csv

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
