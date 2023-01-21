class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    food = Food.find(params[:food_id])
    @food = Food.find(params[:food_id])
    like = current_user.likes.new(food_id: food.id)
    like.save
  end

  def destroy
    food = Food.find(params[:food_id])
    @food = Food.find(params[:food_id])
    like = current_user.likes.find_by(food_id: food.id)
    like.destroy
  end
end
