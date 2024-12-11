require 'rails_helper'

# run cmd command
# rspec spec/models/challenge_spec.rb

RSpec.describe Challenge, type: :model do
 
    
    it 'Testing Challenge Process Content :: Case 1' do
        c = Challenge.new
        c.original_content = "carro.color=rojo;"

        actual = c.process_content
        expect(actual).to eq("{carro:{color:'rojo'}}")
    end

    it 'Testing Challenge Process Content :: Case 2' do
        c = Challenge.new
        c.original_content = "pared.altura=10;orden.precio=100;"

        actual = c.process_content
        expect(actual).to eq("{pared:{altura:'10'},orden:{precio:'100'}}")
    end
    
end