class LikesController < ApplicationController
  def create
    food = Food.find(params[:food_id])
    @food = Food.find(params[:food_id])
    like = current_user.likes.new(food_id: food.id)
    like.save
    # redirect_to request.referer
  end

  def destroy
    food = Food.find(params[:food_id])
    @food = Food.find(params[:food_id])
    like = current_user.likes.find_by(food_id: food.id)
    like.destroy
    # redirect_to request.referer
  end
end
