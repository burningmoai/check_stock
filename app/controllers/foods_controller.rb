class FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food, only: %i[show edit destroy update]

  def index
    @food_new = Food.new
    @category_new = Category.new
    #@foods = Food.all　これは他のユーザーが現れた場合表示されてしまうからcurrent_user必須
    # 複数形にするとallのような感じになる！！
    @lists = current_user.lists.page(params[:page])
    @stocks_limit = current_user.stocks.order(limit: "ASC")
    # @stocks = current_user.stocks.page(params[:page])
    @categories = current_user.categories
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
    @food.save!
      redirect_to request.referer,notice:"食材を登録しました!"
  end

  def destroy
    @food.destroy
    redirect_to request.referer, notice: "食材を削除しました"
  end

  def show
  end

  def edit
  end

  def update
    if @food.update(food_params)
      redirect_to request.referer, notice: "編集が完了しました"
    else
      render :index, notice: "保存できませんでした" #メッセージ表示できない
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

  def set_food
    @food = Food.find(params[:id])
  end
end
