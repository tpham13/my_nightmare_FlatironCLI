require_relative "../config/environment.rb"

class Scraper
    
    def get_page(url)
        page = Nokogiri::HTML(open(url))               
    end 
    
    def get_coffee_blends       
        page = get_page("https://www.philzcoffee.com/shop")         
        page.css("div.span4.cat-row").each do |coffee_blend|  
           
            if CoffeeBlends.all.length <3
            coffee_blend_name = coffee_blend.css("span").children[0].text
            coffee_blend_url = coffee_blend.css("a").attribute("href").value 
            new_coffee_blend = CoffeeBlends.new(coffee_blend_name)          
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
                    coffee_product = page.css("div.facets-item-cell-grid-details a span").children[i].text          
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
           coffee.description = page.css("div.product-details-description").children[0].text   
    end 
   
    def get_this_coffee_description(coffee_name)        
        coffee = Coffee.find_by_name(coffee_name)
        if !coffee.check_for_coffee_description
            get_coffee_description(coffee)
        end 
    end 

end 

 