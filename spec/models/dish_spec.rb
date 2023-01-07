require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}
    it { should have_many :dish_ingredients }
    it { should have_many(:ingredients).through(:dish_ingredients) }
  end

  describe 'total_calories' do 
    it 'totals the calories for the dish' do 
      anthony = Chef.create!(name: "Anthony B")
      mac = anthony.dishes.create!(name: "Mac N Cheese", description: "The best and cheesiest")
      cheddar = Ingredient.create!(name: "Cheddar", calories: 20)
      noodles = Ingredient.create!(name: "Noodles", calories: 50)
      pepper = Ingredient.create!(name: "Pepper Jack Cheese", calories: 100)

      DishIngredient.create!(dish_id: mac.id, ingredient_id: cheddar.id)
      DishIngredient.create!(dish_id: mac.id, ingredient_id: noodles.id)
      DishIngredient.create!(dish_id: mac.id, ingredient_id: pepper.id)

      expect(mac.total_calories).to eq(170)
    end 
  end
end