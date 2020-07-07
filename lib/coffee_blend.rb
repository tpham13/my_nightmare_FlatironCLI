class CoffeeBlends

    attr_accessor :url, :coffees
    attr_reader :name
    @@all = []

    def initialize(name)
        @name = name
        @coffees = []
        @@all << self 
    end 

    def self.all
        @@all
    end  
     
end 

