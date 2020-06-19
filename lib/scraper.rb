# require_relative "../lib.my_nightmare_CLI.rb"
require 'nokogiri'
require 'open-uri'
require_relative 'coffee_blends'
require_relative 'coffee'
require 'pry'

# class Scraper
    def get_page(url)
        page = Nokogiri::HTML(open(url))            
        # page
    end 

    def get_coffee_blends       #Questions: 1. How do I get the page?  2. What values do I need from the HTML? 3. From the structure of the HTML, where are the values that I need? 4. What is the expected syntax for the .css method?
        page = get_page("https://www.philzcoffee.com/shop")         
        page.css("div.span4.cat-row").each do |coffee_blend|  
           
            if CoffeeBlends.all.length <3
            coffee_blend_name = coffee_blend.css("span").children[0]
            coffee_blend_url = coffee_blend.css("a").attribute("href").value 
            new_coffee_blend = CoffeeBlends.new(coffee_blend_name)          #need to figure out how to filter only the first three blends (dark, medium, light)
            new_coffee_blend.url = "https://www.philzcoffee.com#{coffee_blend_url}"
            end          
        end  
    end 
   
    def get_coffee
        get_coffee_blends
        CoffeeBlends.all.each do |coffee_blend|
        end     
            page = get_page(coffee_blend.url)
            binding.pry
            # page.css("div.facets-item-cell-grid-details span").each do |product|
            # page.css("div.facets-item-cell-grid-details").text #.each do |product| 
            # page.css("div.facets-item-cell-grid-details span").children[0].text
            page.css("div.facets-item-cell-grid-details a span").children.text
           
            
                #     new_coffee = CoffeeBlends.new(coffee_blend.css("h6").next)
                #     new_coffee.url = "https://www.philzcoffee.com" + coffee_blend.css("a").attribute("href").value
                #     new_coffee.coffee_blends = coffee_blend
                #     category.coffee << new_coffee
                # end 
                
            # end 
         
    end 

# end 
# puts get_coffee_blends.name
    # def get_coffee_info
    # end 
    
   

    

# end 
#  Test code for get_coffee_blends: 
    # get_coffee_blends
    # CoffeeBlends.all.each do |coffee_blend|
    #     puts coffee_blend.name
    # end  
# end
 
    # def get_coffee
    # get_coffee
    #     # get_coffee_blends
    #     CoffeeBlends.all.each do |coffee_blend|
    #     puts coffee_blend.name
    # end 