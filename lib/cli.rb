#CLI Controller 

require_relative "../config/environment.rb"

# class Coffee_cli
#     attr_accessor :scraper          
    
#     def initialize
#         self.scrape_for_coffee
#     end 

#     def scrape_for_coffee
#         puts "Welcome to the Coffee CLI App. Please wait while the app is loading..."
#         # @scraper = Scraper.new
#         # @scraper.get_coffee
#     end

#     def titleize(word)
#         title = word.split.map(&:capitalize).join(' ')
#         title
#     end 

    def display_coffee_blends      #call for class coffee_blends
        puts "Here are all of Philz Coffee available blends:"
        # puts ""
        CoffeeBlends.all.each do |coffee_blends, index|
            puts " #{index+1}. #{coffee_blends.name}"
         
       
        end
    end

#     def display_coffee           #call for class coffee_clends
#     end 

#     def description_for_one_coffee
#     end 
# end


puts display_coffee_blends
