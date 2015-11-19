class CurrencyExchange::Yahoo
  BASE_URL = 'http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.xchange%20where%20pair%20in%20'
  END_URL = '&env=store://datatables.org/alltableswithkeys'

  def self.get_rates(query)
    rates_parser request_rates(query)
  end

  def self.rates_parser(resp)
    xml = Nokogiri::XML(resp)
    rates = []
    xml.xpath('//rate').each do |rate|
      rates << parse_rate(rate.children)
    end
    rates
  end

  # Private Methods

  def self.request_rates(query)
    CurrencyExchange::Network.get "#{BASE_URL}#{query_builder(query)}#{END_URL}"
  end

  def self.parse_rate(node)
    hash = {}
    node.each do |attribute|
      hash[attribute.name.downcase.to_sym] = attribute.inner_text
    end
    CurrencyExchange::Rate.new(hash)
  end

  def self.query_builder(array)
    query = '('
    array.each_with_index do |item, i|
      query += "%22#{item.first}#{item.last}%22"
      query += ',%20' if i.next < array.size
    end
    query + ')'
  end
  private_class_method :request_rates, :parse_rate, :query_builder
end
