class StocksController < ApplicationController
  def new
    @stock = Stock.new
  end

  def create
    @stock = current_user.stocks.build(stock_params)
    
    if @stock.save
      redirect_to stocks_path, notice: "#{@stock.food.name}をストックに追加しました!"
    else
      @food = Food.new
      @foods = current_user.foods
    end
  end

  def index
    @stocks = current_user.stocks
  end

  def show
  end

  def edit
  end

  def limit
  end

private
 def stock_params
   params.require(:stock).permit(:user_id, :food_id, :amount, :unit, :buy_day, :limit, :memo)
 end
end
