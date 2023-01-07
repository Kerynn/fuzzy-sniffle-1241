class ChefsController < ApplicationController 

  def show 
    @chef = Chef.find(params[:id])
  end

  # def update 
  #   chef = Chef.find(params[:chef_id])
  #   dish = Dish.update(params[:dish_id])

  #   redirect_to chef_path(chef)
  # end
end