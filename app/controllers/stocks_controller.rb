class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock, only: %i[show edit destroy update]

  def new
    @stock = Stock.new
  end

  def create
    @stock = current_user.stocks.build(stock_params)
      if @stock.save
        redirect_to stocks_path, notice: "#{@stock.food.name}をストックに追加しました!"
      else
        flash[:alert] = "内容に不備があります"
        redirect_to foods_path
        #render :indexだと food controllerのindexと同じ変数が必要だったけどコントローラを跨ぐことになるのでリダイレクトで対応
      end
  end

  def index
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
      flash[:alert] = "内容に不備があります"
      redirect_to request.referer
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

end
