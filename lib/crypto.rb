require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_page
	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
	return page
end

def scrapp_symbols
	page = get_page
	symbols = page.xpath('//*[@class="text-left col-symbol"]')
	symbols_array = [] 
	symbols.each do |symbol| 
	symbols_array<< symbol.text 
	end
	return symbols_array
end

def scrapp_prices
	page = get_page
	prices = page.xpath('//*[@class="price"]')
	prices_array = []
	prices.each do |price|
		prices_array << price.text[1..-1].to_f
	end
	return prices_array
end 

def crypto_master
	symbols_array = scrapp_symbols
	prices_array = scrapp_prices 
	a = [] 

	symbols_array.each_with_index do |key, value|
		a << {key => (prices_array)[value]}
	end
	puts a
	return a
end


crypto_master