class FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food, only: %i[show edit destroy update]
  before_action :is_matching_login_user, only: %i[edit update]

  def index
    set_index
  end

  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id
    if @food.save
      redirect_to request.referer,notice:"食材を登録しました!"
    else
      set_index
      render :index
    end
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
      set_index
      render :index
    end
  end
private
  def food_params
    params.require(:food).permit(:name, :user_id, :category_id)
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def set_food
    @food = Food.find(params[:id])
  end

  def set_index
    @food_new = Food.new
    @category_new = Category.new
    @lists = current_user.lists.limit(5)
    @stocks_limit = current_user.stocks.order(limit: "ASC").limit(5)
    @categories = current_user.categories
      if params[:category_id]
        @category = Category.find(params[:category_id])
        @foods = @category.foods.page(params[:page]).per(10)
      else
        @foods = current_user.foods.page(params[:page]).per(10)
      end
  end

  def is_matching_login_user
    user_id = @food.user_id
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to root_path, alert: '他のユーザーの情報は編集できません。'
    end
  end


end
