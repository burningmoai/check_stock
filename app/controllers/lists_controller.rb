class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: %i[edit destroy update]
  before_action :is_matching_login_user, only: %i[edit update]

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

    if current_user.lists.find_by(food_id: params[:list][:food_id]).present?
      @list = current_user.lists.find_by(food_id: params[:list][:food_id])
      @list.amount += params[:list][:amount].to_i

      if @list.save
        redirect_to foods_path, notice: "#{@list.food.name}をお買いものリストに追加しました!"
      else
        render "foods/index"
      end
    else
      if @list.save
        redirect_to foods_path, notice: "#{@list.food.name}をお買いものリストに追加しました!"
      else
        set_food_index
        render "foods/index"
      end
    end
  end

  def edit
  end

  def update
    if @list.update(list_params)
      redirect_to request.referer, notice: "編集が完了しました!"
    else
      redirect_to request.referer
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path, notice: "#{@list.food.name}をお買いものリストから削除しました"
  end

private
  def list_params
    params.require(:list).permit(:user_id, :food_id, :amount, :unit)
  end

  def set_list
    @list = List.find(params[:id])
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
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to root_path, alert: '他のユーザーの情報は編集できません。'
    end
  end

end
