class StocksController < ApplicationController
  def new
    @stock = Stock.new
  end

  def create
    stock = Stock.new(stock_params)
    stock.user_id = current_user.id
    stock.food_id = 
    stock.save
    redirect_to request.referer,notice: "#{@stock.name}をストックに追加しました!"
  end

  def index
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
