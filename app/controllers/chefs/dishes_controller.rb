class Chefs::DishesController < ApplicationController 

  def update 
    chef = Chef.find(params[:chef_id])
    dish = Dish.find(params[:dish_id])
    dish = Dish.update(dish_params)
    redirect_to chef_path(chef)
  end

  private 
  def dish_params 
    params.permit(:name, :description, :chef_id)
  end
end