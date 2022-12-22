class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: %i[edit destroy update]

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
    if @list.save
      redirect_to foods_path, notice: "#{@list.food.name}をお買いものリストに追加しました!"
    else
      flash[:alert] = "内容に不備があります"
      redirect_to foods_path
    end
  end

  def edit
  end

  def update
    if @list.update(list_params)
      redirect_to request.referer, notice: "編集が完了しました!"
    else
      flash[:alert] = "内容に不備があります"
      redirect_to request.referer
    end
  end

  def destroy
    @list.destroy
    redirect_to request.referer, notice: "#{list.food.name}をお買いものリストから削除しました"
  end

private
 def list_params
   params.require(:list).permit(:user_id, :food_id, :amount, :unit)
 end

 def set_list
   @list = List.find(params[:id])
 end
end
