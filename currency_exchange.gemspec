# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'currency_exchange/version'

Gem::Specification.new do |spec|
  spec.name          = 'currency-exchange'
  spec.version       = CurrencyExchange::VERSION
  spec.authors       = ['Ricardo Leitão']
  spec.email         = ['rleitao@onliquid.com']
  spec.licenses      = ['MIT']

  spec.summary       = 'Exchange rates from multiple providers.'
  spec.description   = 'Providers: Yahoo, Google, OpenExchangeRates'
  spec.homepage      = 'https://github.com/letz/currency_exchange'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'vcr', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 1.22'
  spec.add_development_dependency 'simplecov', '~> 0.10'

  spec.add_dependency 'nokogiri', '~> 1.6'
end
