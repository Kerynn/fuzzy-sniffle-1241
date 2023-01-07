require 'rails_helper'

RSpec.describe 'Dish Show Page' do 
  describe 'when I visit a dish show page' do 
    it 'has the dish name and description' do 
      anthony = Chef.create!(name: "Anthony B")
      mac = anthony.dishes.create!(name: "Mac N Cheese", description: "The best and cheesiest")

      visit dish_path(mac)

      expect(page).to have_content(mac.name)
      expect(page).to have_content(mac.description)
    end

    it 'has a list of ingredients for that dish' do 
      anthony = Chef.create!(name: "Anthony B")
      mac = anthony.dishes.create!(name: "Mac N Cheese", description: "The best and cheesiest")
      cheddar = Ingredient.create!(name: "Cheddar", calories: 20)
      noodles = Ingredient.create!(name: "Noodles", calories: 50)
      pepper = Ingredient.create!(name: "Pepper Jack Cheese", calories: 100)

      DishIngredient.create!(dish_id: mac.id, ingredient_id: cheddar.id)
      DishIngredient.create!(dish_id: mac.id, ingredient_id: noodles.id)
      DishIngredient.create!(dish_id: mac.id, ingredient_id: pepper.id)

      visit dish_path(mac)

      expect(page).to have_content(cheddar.name)
      expect(page).to have_content(noodles.name)
      expect(page).to have_content(pepper.name)
    end

    it 'has a total calorie count for the dish' do 
      anthony = Chef.create!(name: "Anthony B")
      mac = anthony.dishes.create!(name: "Mac N Cheese", description: "The best and cheesiest")
      cheddar = Ingredient.create!(name: "Cheddar", calories: 20)
      noodles = Ingredient.create!(name: "Noodles", calories: 50)
      pepper = Ingredient.create!(name: "Pepper Jack Cheese", calories: 100)

      DishIngredient.create!(dish_id: mac.id, ingredient_id: cheddar.id)
      DishIngredient.create!(dish_id: mac.id, ingredient_id: noodles.id)
      DishIngredient.create!(dish_id: mac.id, ingredient_id: pepper.id)

      visit dish_path(mac)

    end

    xit 'shows the chef name' do 

    end
  end
end