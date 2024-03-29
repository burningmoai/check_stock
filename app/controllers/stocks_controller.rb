class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock, only: %i[show edit destroy update]
  before_action :is_matching_login_user, only: %i[edit update]

  def new
    @stock = Stock.new
  end

  def create
    @stock = current_user.stocks.build(stock_params)
      if @stock.save
        redirect_to stocks_path, notice: "#{@stock.food.name}をストックに追加しました!"
      else
        set_food_index
        render "foods/index"
      end
  end

  def index
    set_index
  end

  def show
  end

  def edit
  end

  def limit
    @stocks = current_user.stocks.page(params[:page]).per(10).order(limit: "ASC") #期限の小さい順(昇順)
    @stocks_calendar = params[:name].present? ? Category.find(params[:name]).stock.where(user_id: current_user.id) : Stock.where(user_id: current_user.id)
  end

  def update
    if @stock.update(stock_params)
      redirect_to request.referer, notice: "編集が完了しました"
    else
      set_food_index
      set_index
      render :index
    end
  end

  def destroy
    @stock.destroy
    redirect_to stocks_path, notice: "ストックから削除しました"
  end

private
  def stock_params
    params.require(:stock).permit(:user_id, :food_id, :category_id, :amount, :unit, :buy_day, :limit, :memo)
  end

  def set_stock
    @stock = Stock.find(params[:id])
  end

  def set_index
    @lists = current_user.lists.limit(5)
    @stocks_limit = current_user.stocks.order(limit: "ASC").limit(5)
    @categories = current_user.categories
      if params[:category_id]
        @category = Category.find(params[:category_id])
        @stocks = @category.stocks.page(params[:page]).per(10)
      else
        @stocks = current_user.stocks.page(params[:page]).per(10)
      end
    @stocks_calendar = params[:name].present? ? Category.find(params[:name]).stock.where(user_id: current_user.id) : Stock.where(user_id: current_user.id)
  end

  def set_food_index #foods controllerのindexから持ってきた・・・
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
    user_id = @stock.user_id
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to root_path, alert: '他のユーザーの情報は編集できません。'
    end
  end

end
