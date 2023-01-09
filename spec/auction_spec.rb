require './lib/auction'
require './lib/item'
require './lib/attendee'

RSpec.describe Auction do
    let(:auction) { Auction.new }
    let(:item1) {Item.new('Chalkware Piggy Bank')}
    let(:item2) {Item.new('Bamboo Picture Frame')}
    let(:item3) {Item.new('Homemade Chocolate Chip Cookies')}
    let(:item4) {Item.new('2 Days Dogsitting')}
    let(:item5) {Item.new('Forever Stamps')}
    let(:attendee1) {Attendee.new(name: 'Megan', budget: '$50')}
    let(:attendee2) {Attendee.new(name: 'Bob', budget: '$75')}
    let(:attendee3) {Attendee.new(name: 'Mike', budget: '$100')}

    describe '#initialize' do
        it 'exists' do
            expect(auction).to be_instance_of Auction
        end

        it 'start out with zero items' do
            expect(auction.items).to eq([])
        end
    end

    describe '#can add items' do
        it 'can add items' do
            auction.add_item(item1)
            auction.add_item(item2)

            expect(auction.items).to eq([item1, item2])
        end
    end

    describe '#item names' do
        it 'return item names' do
            auction.add_item(item1)
            auction.add_item(item2)

            expect(auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
        end
    end

    describe '#unpopular items' do
        it 'return unpopular items' do
            auction.add_item(item1)
            auction.add_item(item2)
            auction.add_item(item3)
            auction.add_item(item4)
            auction.add_item(item5)

            item1.add_bid(attendee2, 20)
            item1.add_bid(attendee1, 22)
            item4.add_bid(attendee3, 50)

            expect(auction.unpopular_items).to eq([item2, item3, item5])

            item3.add_bid(attendee2, 15)

            expect(auction.unpopular_items).to eq([item2, item5])
        end
    end

    describe '#potential_revenue' do
        it 'returns potential revenue' do
            auction.add_item(item1)
            auction.add_item(item2)
            auction.add_item(item3)
            auction.add_item(item4)
            auction.add_item(item5)

            item1.add_bid(attendee2, 20)
            item1.add_bid(attendee1, 22)
            item4.add_bid(attendee3, 50)
            item3.add_bid(attendee2, 15)

            expect(auction.potential_revenue).to eq(87)
        end      
    end

    describe '#the bidders in an array' do
        it 'returns the bidders in an array' do
            auction.add_item(item1)
            auction.add_item(item2)
            auction.add_item(item3)
            auction.add_item(item4)
            auction.add_item(item5)

            item1.add_bid(attendee2, 20)
            item1.add_bid(attendee1, 22)
            item4.add_bid(attendee3, 50)

            expect(auction.bidders).to eq([attendee2, attendee1, attendee3])
        end
    end

    describe "#bidders information" do
        it "returns bidders information in a hash" do
            auction.add_item(item1)
            auction.add_item(item2)
            auction.add_item(item3)
            auction.add_item(item4)
            auction.add_item(item5)

            item1.add_bid(attendee2, 20)
            item1.add_bid(attendee1, 22)
            item4.add_bid(attendee3, 50)
            item3.add_bid(attendee2, 15)

            expected = {
                attendee2 => [item1, item3],
                attendee1 => [item1],
                attendee3 => [item4]
            }
            expect(auction.bidder_info).to eq(expected)

        end
    end
end