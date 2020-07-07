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
     
end 

