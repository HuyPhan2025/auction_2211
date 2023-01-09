class Item
    attr_reader :name, :bids

    def initialize(name)
        @name = name
        @bids = Hash.new
    end

    def add_bid(bidder, value)
        @bids[bidder] = 0
        @bids[bidder] += value
    end
    
    def current_high_bid
        highest_bid = @bids.map do |bidder, value|
            value
        end 
        highest_bid.max   
    end 
end