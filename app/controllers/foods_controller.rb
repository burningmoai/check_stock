class FoodsController < ApplicationController
  def index
    @food = Food.new
    @foods = Food.all
  end

  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id

    @food.save
      redirect_to request.referer,notice:"食材を登録しました!"
  end

  def destroy
    food = Food.find(params[:id])
    food.destroy
    redirect_to request.referer, notice: "食材を削除しました"
  end

  def show
  end

  def edit
  end
private
  def food_params
    params.require(:food).permit(:name, :user_id, :category_id)
  end
end
