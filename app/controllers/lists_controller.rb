class ListsController < ApplicationController
  def index
    @lists = current_user.lists
    @list = List.new
    @stock = Stock.new
  end

  def new
    @list = @List.new
  end

  def create
    @list = current_user.lists.build(list_params)
  # binding.pry
    if @list.save

      redirect_to foods_path, notice: "#{@list.food.name}をストックに追加しました!"
    else
      @food = Food.new
      @foods = current_user.foods
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    list = List.find(params[:id])
    # binding.pry
    list.update(list_params)
    redirect_to request.referer, notice: "編集が完了しました!"
  end

  def destroy
    list = List.find(params[:id])
    list.destroy
    redirect_to request.referer, notice: "#{list.food.name}をお買いものリストから削除しました"
  end

private
 def list_params
   params.require(:list).permit(:user_id, :food_id, :amount, :unit)
 end
end
