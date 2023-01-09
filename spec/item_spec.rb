require './lib/auction'
require './lib/item'
require './lib/attendee'

RSpec.describe Item do
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
            expect(item1).to be_instance_of(Item)
        end

        it 'has attributes' do
            expect(item1.name).to eq('Chalkware Piggy Bank')
        end
    end

    describe '#attendees bid' do
        it 'it start with no bid' do
            auction.add_item(item1)
            auction.add_item(item2)
            auction.add_item(item3)
            auction.add_item(item4)
            auction.add_item(item5)
            
            expect(item1.bids).to eq({})
        end

        it 'returns attendees bid' do
            auction.add_item(item1)
            auction.add_item(item2)
            auction.add_item(item3)
            auction.add_item(item4)
            auction.add_item(item5)

            expect(item1.bids).to eq({})

            item1.add_bid(attendee2, 20)
            item1.add_bid(attendee1, 22)

            expected = {
                attendee2 => 20,
                attendee1 => 22
            }
            expect(item1.bids).to eq(expected)
        end

        it 'returns the current highest bid' do
            auction.add_item(item1)
            auction.add_item(item2)
            auction.add_item(item3)
            auction.add_item(item4)
            auction.add_item(item5)

            item1.add_bid(attendee2, 20)
            item1.add_bid(attendee1, 22)

            expect(item1.current_high_bid).to eq(22)
        end
    end
end

