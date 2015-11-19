class CurrencyExchange::Google
  BASE_URL = 'http://www.google.com/finance/converter'
  QUERY = 'a=1&from=%s&to=%s'

  def self.get_rate(query)
    rates_parser request_rate(query)
  end

  def self.rates_parser(resp)
    exchange = Nokogiri::HTML(resp).css('#currency_converter_result')
    currency1 = exchange.children.first.text.split(' ')[1]
    rate, currency2 = exchange.css('.bld').inner_text.split(' ')
    CurrencyExchange::Rate.new(name: "#{currency1}/#{currency2}", rate: rate)
  end

  def self.request_rate(query)
    CurrencyExchange::Network.get "#{BASE_URL}?#{query_builder(query)}"
  end

  def self.query_builder(query)
    QUERY % query
  end
end
