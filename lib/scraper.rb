require_relative "../config/environment.rb"

class Scraper
    def get_page(url)
        page = Nokogiri::HTML(open(url))            
        
    end 
    
    def get_coffee_blends       #Questions: 1. How do I get the page?  2. What values do I need from the HTML? 3. From the structure of the HTML, where are the values that I need? 4. What is the expected syntax for the .css method?
        page = get_page("https://www.philzcoffee.com/shop")         
        page.css("div.span4.cat-row").each do |coffee_blend|  
           
            if CoffeeBlends.all.length <3
            coffee_blend_name = coffee_blend.css("span").children[0].text
            coffee_blend_url = coffee_blend.css("a").attribute("href").value 
            new_coffee_blend = CoffeeBlends.new(coffee_blend_name)          #need to figure out how to filter only the first three blends (dark, medium, light)
            new_coffee_blend.url = "https://www.philzcoffee.com#{coffee_blend_url}"
            end         
        end 
        # binding.pry 
    end 


    
   
    def get_coffee
        get_coffee_blends
        CoffeeBlends.all.each do |coffee_blend| 
            page = get_page(coffee_blend.url)
            i = 0

            while i < 3
            page.css("div.facets-item-cell-grid-details").each do |product|

            if coffee_blend.coffee.length < 3
                coffee_product = page.css("div.facets-item-cell-grid-details a span").children[i].text  #added .text for coffee_product to work         
                # binding.pry 
                new_coffee_product = Coffee.new(coffee_product)
                new_coffee_product.url = "https://www.philzcoffee.com" + product.css("a").attribute("href").value
                new_coffee_product.blend = coffee_blend
                coffee_blend.coffee << new_coffee_product
                i += 1
            end
            # binding.pry 
            end 
        end 
         end 
         
    end 
    

    def get_coffee_description(coffee)
       page = get_page(coffee.url) 
           coffee.description = page.css("div.product-details-description").children[0].text   #added .text here to see if the cli get_description method will work
    # binding.pry    
    end 
    # binding.pry

    def get_this_coffee_description(coffee_name)        #user input coffee product, select 
        coffee = Coffee.find_by_name(coffee_name)
        if !coffee.check_for_coffee_description
            get_coffee_description(coffee)
        end 
    end 

    # def get_all_coffee_description
    #     Coffee.all.each do |coffee|
    #         if !coffee.check_for_coffee_description
    #             get_coffee_description(coffee)
    #         end
    #     end
    # end 
 
end 

 
    

   
# Coffee.all.each do |coffee|
#      get_coffee_description(coffee)
  
# end
    

    

   
    # Test; 

                  #need to figure out how to filter only the first three blends (dark, medium, light)
      

    

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