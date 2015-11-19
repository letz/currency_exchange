class CurrencyExchange::Network
  def self.get(url)
    Net::HTTP.get_response(URI.parse url).body
  rescue SocketError
    ''
  end
end
