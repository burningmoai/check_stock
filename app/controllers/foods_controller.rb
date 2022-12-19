class FoodsController < ApplicationController
  def index
    @food_new = Food.new
    @list = List.new
    @stock = Stock.new
    @category_new = Category.new
    #@foods = Food.all　これは他のユーザーが現れた場合表示されてしまうからcurrent_user必須
    # 複数形にするとallのような感じになる！！
    @lists = current_user.lists.page(params[:page])
    @stocks = current_user.stocks.page(params[:page])
    @categories = Category.all
      if params[:category_id]
        @category = Category.find(params[:category_id])
        @foods = @category.foods.page(params[:page]).per(10)
      else
        @foods = current_user.foods.page(params[:page]).per(10)
      end
    # list = List.find(list_params[:id])
    # list.update(list_params)
    # redirect_to foods_path, notice: "編集が完了しました"
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
    @food = Food.find(params[:id])
    if @food.update(food_params)
      redirect_to request.referer, notice: "編集が完了しました"
    else
      render :edit, notice: "保存できませんでした" #メッセージ表示できない
    end
  end
private
  def food_params
    params.require(:food).permit(:name, :user_id, :category_id)
  end

  def category_params
    params.require(:category).permit(:name)
  end
  # def list_params
  # params.require(:list).permit(:user_id, :food_id, :amount, :unit)
  # end
end
