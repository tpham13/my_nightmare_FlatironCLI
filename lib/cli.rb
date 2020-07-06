require_relative "../config/environment.rb"

class Coffee_cli
    
    attr_accessor :scraper
    
    def call

        puts "\n ========================================================================================== \n\n"
        puts "Welcome to the Coffee CLI App."
        puts "This app will allow you to learn all about the various coffees that Philz Coffee provides. \n\n"
        
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
        title = word.split(" ").map { |word| nocaps.include?(word) ? 
                word : word.capitalize }.join(" ")
        title
    end
    
    def display_blends      
        puts "Here are all of Philz Coffee available blends: \n\n"
        CoffeeBlends.all.each_with_index do |blend, index|      
            puts "  #{index+1}. #{blend.name}"
        end  
    end
 
    def user_choice
        input = gets.chomp
        choice = titleize(input)    

    end 

    def display_coffees  

        puts "\nPlease type the blend that you're interested in and press 'Enter' if you want to see the coffees available for that blend. \n\n"
        
        input = user_choice
        puts ""
        
        blend_coffees = Coffee.all_coffees_in(input)
        
        if blend_coffees.length > 0         
       
            puts "Here are all of our coffees for #{input}: "
            blend_coffees.each_with_index do |coffee, index|
                puts "#{index+1}. #{coffee.name}"
            end 
         
        else
            puts "Sorry that doesn't appear to be a valid blend..."
            display_blends
            display_coffees
        end 
    end 

    def display_description             
        input = nil
        until input == 'Back' || input == 'back'
            puts "\nWhat type of coffee would you like to learn about?"
            puts "Type the name of the coffee to get its description or type 'Back' to go to the previous page. \n\n"

            input = user_choice
            coffee = Coffee.find_by_name(input)

            if coffee != nil 
                @scraper.get_this_coffee_description(input)
                puts "\nHere are the details for our #{coffee.name} coffee:"
                puts coffee.description

                until input == 'Exit' || input == 'exit'
                    puts "\nWould you like to look at more coffees or would you like to exit now?"
                    puts "If you want to look at more coffees, enter 'Home'."
                    puts "If you want to exit, enter 'Exit'. \n\n"
            
                    input = user_choice
                    
                    if input == "Home" || input == "home"
                        call
                    
                    elsif input == "Exit" || input == "exit"
                        puts "\nThank you for using our  Coffee CLI App. Goodbye! \n\n" 
                        exit 
                    else
                        puts "Please try again"
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
     














