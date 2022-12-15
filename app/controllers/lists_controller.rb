class ListsController < ApplicationController
  def index
    @lists = current_user.lists
  end

  def new
    @list = @List.new
  end

  def edit
  end

  def create
    @list = current_user.lists.build(list_params)

    if @list.save
      redirect_to foods_path, notice: "#{@list.food.name}をストックに追加しました!"
    else
      @food = Food.new
      @foods = current_user.foods
    end
  end

private
 def list_params
   params.require(:list).permit(:user_id, :food_id, :amount, :unit)
 end
end
