# require_relative "../lib.my_nightmare_CLI.rb"
require 'nokogiri'
require 'open-uri'
require_relative 'coffee_blends'
require_relative 'coffee'
require 'pry'

class Scraper
    def get_page(url)
        page = Nokogiri::HTML(open(url))            
        
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
            page = get_page(coffee_blend.url)
            i = 0

            while i < 3
            page.css("div.facets-item-cell-grid-details").each do |product|

            if coffee_blend.coffee.length < 3
                coffee_product = page.css("div.facets-item-cell-grid-details a span").children[i]            
                #puts coffee_product
                new_coffee_product = Coffee.new(coffee_product)
                new_coffee_product.url = "https://www.philzcoffee.com" + product.css("a").attribute("href").value
                new_coffee_product.blend = coffee_blend
                coffee_blend.coffee << new_coffee_product
                i += 1
            end
            end 
        end 
         end 
    end 


    def get_coffee_description(coffee)
       
            page = get_page(coffee.url)
            coffee.description = page.css("div.product-details-description").children[0]
    end 
     
    def get_this_coffee_description(coffee_name) 
        coffee = Coffee.find_by_name(coffee_name)
        if !coffee.check_for_coffee_description
            get_coffee_description(coffee)
        end 
    end 

    def get_all_coffee_description
        Coffee.all.each do |coffee|
            if !coffee.check_for_coffee_description
                get_coffee_description(coffee)
            end
        end
    end 
 
end 

 
    
# get_coffee
   
# Coffee.all.each do |coffee|
#      get_coffee_description(coffee)
  
# end
    

    

   
    # Test; 
# get_coffee
# Coffee.all.each do |coffee|
#     puts "Coffee name: " + coffee.name
#     puts "Coffee url: " + coffee.url
#     puts "Coffee blend name: " + coffee.blend.name
#     puts "Coffee blend url: " + coffee.blend.url
#     puts "=================================="
# end  

    

#  Test code for get_coffee_blends: 
    # get_coffee_blends
    # CoffeeBlends.all.each do |coffee_blend|
    #     puts coffee_blend.name
    # end  
# end
 
    # get_coffee
    #     # get_coffee_blends
    #     CoffeeBlends.all.each do |coffee_blend|
    #     puts coffee_blend.name
    # end 