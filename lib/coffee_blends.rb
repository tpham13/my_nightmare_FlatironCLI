require_relative "../config/environment.rb"

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

