require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
    it { should have_many :machine_snacks }
    it { should have_many :snacks }
  end

  describe "methods" do
    it "#average_price returns the average price of snacks" do
      owner = Owner.create(name: "Sam's Snacks")
      dons  = owner.machines.create(location: "Don's Mixed Drinks")
      snack_1 = dons.snacks.create(name: "KitKat", price: 1)
      snack_2 = dons.snacks.create(name: "Oreo", price: 1.5)

      expect(dons.average_price).to eq(1.25)
    end

    it "#add_snack adds a snack to machine" do
      owner = Owner.create(name: "Sam's Snacks")
      turing = owner.machines.create(location: "Turing Basement")
      snack_1 = Snack.create(name: "KitKat", price: 1)

      expect(turing.snacks).to eq([])

      turing.add_snack(snack_1)

      expect(turing.snacks).to eq([snack_1])
    end

    it "#count_of_snacks" do
      owner = Owner.create(name: "Sam's Snacks")
      turing = owner.machines.create(location: "Turing Basement")
      snack_1 = Snack.create(name: "KitKat", price: 1)
      snack_2 = Snack.create(name: "KitKat", price: 1)

      turing.add_snack(snack_1)
      expect(turing.count_of_snacks).to eq(1)
      turing.add_snack(snack_2)
      expect(turing.count_of_snacks).to eq(2)
    end
  end
end
