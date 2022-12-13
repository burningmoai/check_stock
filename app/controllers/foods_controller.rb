class FoodsController < ApplicationController
  def index
    @food = Food.new
    #@foods = Food.all
    @foods = current_user.foods
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
    @food = Food.find(params[:id])
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    food = Food.find(params[:id])
    food.update(food_params)
    redirect_to food_path, notice: "編集が完了しました"
  end
private
  def food_params
    params.require(:food).permit(:name, :user_id, :category_id)
  end
end
