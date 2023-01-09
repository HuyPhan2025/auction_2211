class Auction
    attr_reader :items

    def initialize
        @items = []
    end

    def add_item(item)
        @items.push(item)
    end

    def item_names
        @items.map do |item|
            item.name           
        end
    end
    
    def unpopular_items
        unpopular = @items.map do |item|
            item if item.bids.empty?          
        end   
        unpopular.compact         
    end

    def potential_revenue
        bids = items.filter_map do |item|
            item.current_high_bid     
        end
        bids.sum
    end          

    def bidders
        attendees_who_bid = items.map do |item|
            item.bids.keys
        end
        attendees_who_bid.flatten.compact
    end

    def bidder_info
        info_of_bidders = Hash.new 
        info_by_bidder_bids = items.group_by do |item|
            item.bids
        end
        info_by_bidder_bids.each do |bidder, info|
            info_of_bidders[bidders] = info
        end
        info_of_bidders
    end
end


