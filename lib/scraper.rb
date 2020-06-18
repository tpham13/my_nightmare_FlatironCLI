# require_relative "../lib.my_nightmare_CLI.rb"

require 'nokogiri'
require 'open-uri'
url =  "https://www.philzcoffee.com/shop/coffee"

# class Scraper

    def get_page(url)
        page = Nokogiri::HTML(open(url))
        puts page
    end 

    def get_coffee_categories 
        page = get_page("https://www.philzcoffee.com/shop/coffee.html")
        page.css()
    end 

    def get_coffee_blends
    end 

    def get_coffee_description
    end 

    def get_coffee_price
    end 
    



# end 
