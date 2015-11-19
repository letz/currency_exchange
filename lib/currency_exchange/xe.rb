class CurrencyExchange::Xe
  BASE_URL = 'http://www.xe.com/currencyconverter/convert/'
  QUERY = 'Amount=1&From=%s&To=%s'

  def self.get_rate(query)
    rates_parser request_rate(query)
  end

  def self.rates_parser(resp)
    doc = Nokogiri::HTML(resp)
    date = parse_date(doc)
    currency1, currency2, rate = parse_rate doc

    CurrencyExchange::Rate.new("#{currency1}/#{currency2}", rate, date: date)
  end

  # Private Methods

  def self.request_rate(query)
    CurrencyExchange::Network.get "#{BASE_URL}?#{query_builder(query)}"
  end

  def self.query_builder(query)
    QUERY % query
  end

  def self.parse_date(doc)
    doc.css('.uccMMR').css('a').children.first.inner_text.
      split('Mid-market rates: ').last
  end

  def self.parse_rate(doc)
    exchange = doc.css('.uccResUnit').css('.leftCol')[0].inner_text
    currency1, currency2 = exchange.gsub(/[\u0080-\u00ff]/, ' ').split(' = ')
    currency1 = currency1.split(' ').last
    rate, currency2 = currency2.split(' ')
    [currency1, currency2, rate]
  end
  private_class_method :request_rate, :query_builder, :parse_date, :parse_rate
end
