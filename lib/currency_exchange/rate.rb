class CurrencyExchange::Rate
  attr_accessor :name, :rate, :time, :ask, :bid

  DATE_FORMAT = '%m/%d/%Y %H:%M %P'

  def initialize(name, rate, options = {})
    @name = name
    @rate = rate.to_f
    @time = parse_date options[:date], options[:time]
    @ask = options[:ask].to_f
    @bid = options[:bid].to_f
  end

  def convert_value(value)
    rate * value
  end

  def self.rate_for(currency1, currency2)
    CurrencyExchange::Yahoo.get_rates [[currency1, currency2]]
  end

  private

  def parse_date(date, time)
    parse_date_format(date, time) || parse_date_no_format(date) || Time.now
  end

  def parse_date_format(date, time)
    Time.strptime "#{date} #{time}", DATE_FORMAT
    rescue ArgumentError
  end

  def parse_date_no_format(date)
    Time.parse date
    rescue ArgumentError, TypeError
  end
end
