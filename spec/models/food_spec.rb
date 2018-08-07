require 'rails_helper'

describe Food do
    it "is valid with a name and description" do
        food = Food.new(
            name: "Nasi Uduk",
            description: "Betawi style steamed rice cooked is coconuts milk, Delicious!",
            price: 10000.0
        )
        expect(food).to be_valid
    end
    it "is invalid without a name" do
        food = Food.new(
            name: nil,
            description: "Betawi style steamed rice cooked is coconuts milk, Delicious!",
            price: 10000.0
        )
        food.valid?
        expect(food.errors[:name]).to include("can't be blank")
    end
    it "is invalid without a description" do
        food = Food.new(
            name: "Nasi Uduk",
            description: nil,
            price: 10000.0
        )
        food.valid?
        expect(food.errors[:description]).to include("can't be blank")
    end
    it "is invalid with a duplicate name" do
        food1 = Food.create(
            name: "Nasi Uduk",
            description: "Betawi style steamed rice cooked in coconuts milk. Delicious!",
            price: 10000.0
        )

        food2 = Food.new(
            name: "Nasi Uduk",
            description: "Just with a different description",
            price: 10000.0
        )

        food2.valid?
        expect(food2.errors[:name]).to include("has already been taken")
    end
    it "returns a sorted array of results that match" do
        food1 = Food.create(
            name: "Nasi Uduk",
            description: "Betawi style steamed rice cooked in coconuts milk. Delicious!",
            price: 10000.0
        )

        food2 = Food.create(
            name: "Kerak Telor",
            description: "Kerak Telor steamed rice cooked in coconuts milk. Delicious!",
            price: 8000.0
        )

        food3 = Food.create(
            name: "Nasi Semur Jengkol",
            description: "Semur Jengkol steamed rice cooked in coconuts milk. Delicious!",
            price: 8000.0
        )

        expect(Food.by_letter("N")).to eq([food3,food1])
    end
end