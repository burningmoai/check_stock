class StocksController < ApplicationController
  def new
    @stock = Stock.new
  end

  def create
    @stock = current_user.stocks.build(stock_params)

    if current_user.stocks.find_by(food_id: params[:stock][:food_id]).present? #同じ食材ある？
      stock = current_user.stocks.find_by(food_id: params[:stock][:food_id])
      stock.amount += params[:stock][:amount].to_i #stockパラムの数量を足す

      if @stock.save #保存
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
    @lists = current_user.lists.page(params[:page])
    @categories = Category.all
      if params[:category_id]
        @category = Category.find(params[:category_id])
        @stocks = @category.stocks.page(params[:page]).per(10)
      else
        @stocks = current_user.stocks.page(params[:page]).per(10)
      end
  end

  def show
    @stock = Stock.find(params[:id])
  end

  def edit
    @stock = Stock.find(params[:id])
  end

  def limit
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
