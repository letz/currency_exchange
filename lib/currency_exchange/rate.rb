class CurrencyExchange::Rate
  attr_accessor :name, :rate, :time, :ask, :bid

  DATE_FORMAT = '%m/%d/%Y %H:%M %P'

  def initialize(name:, rate:, date: nil, time: nil, ask: nil, bid: nil)
    @name = name
    @rate = rate.to_f
    @time = parse_date date, time
    @ask = ask.to_f
    @bid = bid.to_f
  end

  def convert_value(value)
    rate * value
  end

  def self.rate_for(currency1, currency2)
    CurrencyExchange::Yahoo.get_rates [[currency1, currency2]]
  end

  def parse_date(date, time)
    Time.strptime "#{date} #{time}", DATE_FORMAT
  rescue ArgumentError
    Time.zone.now
  end
end
