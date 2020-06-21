



class Coffee
    attr_reader :name
    attr_accessor   :url, :description, :blend
    @@all = []

    def initialize(name)
        @name = name
        @@all << self
        self.description = ""
        
    end

    def self.all
        @@all
    end 

    def self.find_by_name(name)
        @@all.detect {|coffee| coffee.name == name}
    end 

    def check_for_coffee_description
        self.description.length > 0 && self.pricing.length > 0 
    end 

    def self.all_coffees_in(coffee_blend)
        @@all.select {|coffee| coffee.blend == coffee_blend}
    end 

end 