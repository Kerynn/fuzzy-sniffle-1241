require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should have_many :dishes}
    it {should have_many(:ingredients).through(:dishes)}
  end

  describe 'unique ingredients' do 
    it 'displays a unique list of ingredients of this chef' do 
      anthony = Chef.create!(name: "Anthony B")
      mac = anthony.dishes.create!(name: "Mac N Cheese", description: "The best and cheesiest")
      burger = anthony.dishes.create!(name: "Big Ol Burger", description: "It's big!")
      fried_chicken = anthony.dishes.create!(name: "Fried Chicken", description: "Crispy and delicious")
      
      cheddar = Ingredient.create!(name: "Cheddar", calories: 20)
      noodles = Ingredient.create!(name: "Noodles", calories: 50)
      pepper = Ingredient.create!(name: "Pepper Jack Cheese", calories: 100)

      DishIngredient.create!(dish_id: mac.id, ingredient_id: cheddar.id)
      DishIngredient.create!(dish_id: mac.id, ingredient_id: noodles.id)
      DishIngredient.create!(dish_id: mac.id, ingredient_id: pepper.id)

      patty = Ingredient.create!(name: "Burger Patty", calories: 80)
      
      DishIngredient.create!(dish_id: burger.id, ingredient_id: cheddar.id)
      DishIngredient.create!(dish_id: burger.id, ingredient_id: patty.id)

      expect(anthony.unique_ingredients).to eq([cheddar, noodles, pepper, patty])
    end
  end
end