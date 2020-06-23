#CLI Controller 

require_relative "../config/environment.rb"

class Coffee_cli
    attr_accessor :scraper, :blend, :name
    
    def call
        puts "Welcome to the Coffee CLI App. Please wait while the app is loading..."
        # scrape_for_coffee
        # initialize
        # scrape_for_coffee
        # titleize
        display_coffee_blends
        display_coffee
    end    
    
    def initialize
        
        self.scrape_for_coffee
        # @call = []
    end 

    def scrape_for_coffee
        # puts "Welcome to the Coffee CLI App. Please wait while the app is loading..."
        puts ""
        @scraper = Scraper.new
        @scraper.get_coffee
    end

    def titleize(word)
        title = word.split.map(&:capitalize).join(' ')
        title
    end 

    def display_coffee_blends      #call for  coffee_blends class
        puts "Here are all of Philz Coffee available blends:"
        puts ""
    
        CoffeeBlends.all.each_with_index do |blend, index|      #this will place an interger and a dot in front of each blend
            puts "  #{index+1}. #{blend.name}"
            
        end  
        puts ""
        puts "Please enter the name of the coffee blend that you're interested in:" #need an if statement for when the user enter the blend to execute the next code based on user's decision
        puts ""
    end

    # def select_blend
    # end 

    def display_coffee(blend)     #call for class coffee
        blend_name = titleize(blend)
        blend_coffees = Coffee.all_coffees_in(blend_name)
        if blend_coffees.length > 0 
            puts "Here are all of our #{blend}: "
            blend_coffees.each_with_index do |coffee, index|
                puts "#{index+1}. #{titleize(coffee.name)}"
            end 
        else
            puts "Sorry that doesn't appear to be a valid blend..."
            display_coffee_blends
        end 
    end 

     
end

# a = Coffee_cli.new 
# b = a.display_coffee_blends
# c = a.display_coffee("Lighter Blends")


Coffee_cli.new.call




