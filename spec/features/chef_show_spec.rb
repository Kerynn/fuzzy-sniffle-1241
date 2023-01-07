require 'rails_helper'

RSpec.describe 'Chef Show Page' do 
  describe 'when I visit a chef show page' do 
    it 'has the name of the chef and their dishes' do 
      anthony = Chef.create!(name: "Anthony B")
      mac = anthony.dishes.create!(name: "Mac N Cheese", description: "The best and cheesiest")
      burger = anthony.dishes.create!(name: "Big Ol Burger", description: "It's big!")
      fried_chicken = anthony.dishes.create!(name: "Fried Chicken", description: "Crispy and delicious")

      visit chef_path(anthony)

      expect(page).to have_content(anthony.name)
      expect(page).to have_content(mac.name)
      expect(page).to have_content(burger.name)
      expect(page).to have_content(fried_chicken.name)
    end

    it 'has a form to add a dish to that chef' do 
      anthony = Chef.create!(name: "Anthony B")
      mac = anthony.dishes.create!(name: "Mac N Cheese", description: "The best and cheesiest")
      burger = anthony.dishes.create!(name: "Big Ol Burger", description: "It's big!")
      fried_chicken = anthony.dishes.create!(name: "Fried Chicken", description: "Crispy and delicious")

      jim = Chef.create!(name: "Jim")
      ceasar = jim.dishes.create!(name: "Ceasar Salad", description: "You will love the dressing")
      
      visit chef_path(anthony)
      
      expect(page).to_not have_content(ceasar.name)

      fill_in :dish_id, with: ceasar.id 
      click_button "Add Dish to Chef"

      expect(current_path).to eq chef_path(anthony)
      expect(page).to have_content(ceasar.name)
    end

    it 'has a link to view all the chef ingredients' do 
      anthony = Chef.create!(name: "Anthony B")
      mac = anthony.dishes.create!(name: "Mac N Cheese", description: "The best and cheesiest")
      burger = anthony.dishes.create!(name: "Big Ol Burger", description: "It's big!")
      fried_chicken = anthony.dishes.create!(name: "Fried Chicken", description: "Crispy and delicious")

      visit chef_path(anthony)

      expect(page).to have_link "View all Ingredients for this Chef"
    end

    it 'will show a unique list of all ingredients the chef uses' do 
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

      visit chef_path(anthony)

      click_link "View all Ingredients for this Chef"

      expect(current_path).to eq "/chefs/#{anthony.id}/ingredients" 

      expect(page).to have_content(cheddar.name, count: 1)
      expect(page).to have_content(noodles.name, count: 1)
      expect(page).to have_content(pepper.name, count: 1)
      expect(page).to have_content(patty.name, count: 1)
    end
  end
end