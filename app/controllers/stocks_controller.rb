class StocksController < ApplicationController
  before_action :authenticate_user!

  def new
    @stock = Stock.new
  end

  def create
    @stock = current_user.stocks.build(stock_params)

  #現段階で全く機能してない
    if current_user.stocks.find_by(food_id: params[:stock][:food_id]).present? #同じ食材ある？
      stock = current_user.stocks.find_by(food_id: params[:stock][:food_id])
      stock.amount += params[:stock][:amount].to_i #stockパラムの数量を足す
  # binding.pry
      if @stock.save #保存
        # logger.debug @deliver.errors.inspect
        redirect_to stocks_path, notice: "#{@stock.food.name}をストックに追加しました!"
      else #保存ができなかったらindex
        @food = Food.new
        @foods = current_user.foods
        # food controllerのindexと同じ変数が必要
      end

    else #同じ食材がない時そのまま保存
    #いま数量足せてないけど上(if)が実行できてることになっている・・・
      @stock.save
      redirect_to stocks_path, notice: "#{@stock.food.name}をストックに追加しました!"
    end
  end

  def index
    # @stocks = current_user.stocks.page(params[:page])
    @lists = current_user.lists.limit(5)
    @stocks_limit = current_user.stocks.order(limit: "ASC") #反映されず→気付いたら反映されていた！！！！！！
    @categories = Category.all
      if params[:category_id]
        @category = Category.find(params[:category_id])
        @stocks = @category.stocks.page(params[:page])
      else
        @stocks = current_user.stocks.page(params[:page])
      end

    # @categories = Category.all
    @stocks_calendar = params[:name].present? ? Category.find(params[:name]).stock.where(user_id: current_user.id) : Stock.where(user_id: current_user.id)
  end

  def show
    @stock = Stock.find(params[:id])
  end

  def edit
    @stock = Stock.find(params[:id])
  end

  def limit
    @stocks = current_user.stocks.order(limit: "ASC")
    @stocks_calendar = params[:name].present? ? Category.find(params[:name]).stock.where(user_id: current_user.id) : Stock.where(user_id: current_user.id)
  end

  def update
    stock = Stock.find(params[:id])
    stock.update(stock_params)
    redirect_to request.referer, notice: "編集が完了しました"
  end

  def destroy
    stock = Stock.find(params[:id])
    stock.destroy
    redirect_to request.referer, notice: "ストックから削除しました"
  end

private
  def stock_params
    params.require(:stock).permit(:user_id, :food_id, :category_id, :amount, :unit, :buy_day, :limit, :memo)
  end
end
