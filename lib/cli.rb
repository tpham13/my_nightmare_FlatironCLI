#CLI Controller 

require_relative "../config/environment.rb"

class Coffee_cli
    attr_accessor :scraper, :blend
    attr_reader :name
    
    def call
        puts ""
        puts "=========================================================================================="
        puts "Welcome to the Coffee CLI App."
        puts "This app will allow you to learn all about the various coffees that Philz Coffee provides."
        puts "Please wait while the app is loading..."
        puts ""
        
        display_blends
        display_coffees
        display_description
    end    
    
    def initialize  
        @scraper = Scraper.new
        @scraper.get_coffee
    end 
    
    def titleize(word)
        nocaps = ["the", "of"]
        # title = word.split.map(&:capitalize).join(' ')
        # title = input.split(" ").map { |word| nocaps.include?(word) ? word : word.capitalize }.join(" ")
        title = word.split(" ").map { |word| nocaps.include?(word) ? word : word.capitalize }.join(" ")
        title
    end
    
    def display_blends      
        puts "Here are all of Philz Coffee available blends:"
        puts ""
    
        CoffeeBlends.all.each_with_index do |blend, index|      
            puts "  #{index+1}. #{blend.name}"
            
        end  
    end
 
    
    def display_coffees   #refactor: 2 methods--> 1. get user choice, 2. display coffee using the choice
        
        puts ""
        puts "Please type the blend that you're interested in and press 'Enter' if you want to see the coffees available for that blend."
        puts ""

        input = gets.chomp
        blend = titleize(input)
        puts ""
        blend_coffees = Coffee.all_coffees_in(blend)
        
        if blend_coffees.length > 0         #if there are coffee under this blend then:
       
            puts "Here are all of our products for #{blend}: "
            blend_coffees.each_with_index do |coffee, index|
                puts "#{index+1}. #{coffee.name}"
            end 
         
        else
            puts "Sorry that doesn't appear to be a valid blend..."
            display_blends
            display_coffees

        end 
    end 

    def display_coffee_info(coffee_name)
        coffee = Coffee.find_by_name(coffee_name)
            puts " "
            puts "Here are the details for our #{coffee.name} coffee:"
            puts coffee.description
    end 

    def display_description             #refactor: 1. user choice  2.
        input = nil
        until input == 'Back' || input == 'back'
            puts ""
            puts "What type of coffee would you like to learn about?"
            puts "Type the name of the coffee to get its description or type 'Back' to go to the previous page"
            puts ""

            input = gets.chomp 
            description = titleize(input)
            coffee = Coffee.find_by_name(description)

            if coffee != nil 
                @scraper.get_this_coffee_description(coffee.name)
                display_coffee_info(coffee.name)
                until input == 'Exit' || input == 'exit'
                    puts ""
                    puts "Would you like to look at more coffees or would you like to exit now?"
                    puts "If you want to look at more coffees, enter 'Home'"
                    puts "If you want to exit, enter 'Exit'"
                    input = gets.chomp
                    if input == "Home" || input == "home"
                        call
                    elsif input == "Exit" || input == "exit"
                        puts "goodbye"
                        exit 
                    else
                        puts "please try again"
                    end 
            end
            
            elsif input == "Back" || input == "back"
                call

            else 
                puts "Please try again"
           
            end 
        end    
        
    end 
       
end 
     



