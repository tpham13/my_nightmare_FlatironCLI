# require_relative "../lib.my_nightmare_CLI.rb"
require 'nokogiri'
require 'open-uri'

class CoffeeBlends
    attr_accessor :url, :coffee
    attr_reader :name
    @@all = []

    def initialize(name)
        @name = name
        @coffee = []
        @@all << self 
    end 

    def self.all
        @@all
    end 

    def self.check_for_coffee_blends(coffee_blends)
        self.all.detect {|x| x.name == coffee_blends}
    end 
end 

# class Scraper

    def get_page(url)
        page = Nokogiri::HTML(open(url))            #::HTML parsing the pageq
        # page
    end 

    def get_coffee_blends
        page = get_page("https://www.philzcoffee.com/shop")
        # test = page.css("div.span4.cat-row a")              
        page.css("div.cat-title span").each do |coffee_blend|  #css is a selector that help get the page
            coffee_blend_name = coffee_blend.text
            new_coffee_blend = CoffeeBlends.new(coffee_blend_name)
            # puts new_coffee_blend.name
    end 
   
    def get_coffee_blends
    end 
 
    # def get_coffee_description
    # end 

    # def get_coffee_price
    # end 




# end 
