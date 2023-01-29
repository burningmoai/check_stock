class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[destroy update]
  before_action :is_matching_login_user, only: %i[edit update]

  def index
    set_index
  end

  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id
    if @category.save
      redirect_to categories_path, notice: "カテゴリが新規登録されました"
    else
      set_index
      render :index
    end
  end

  def destroy
    @category.destroy
    redirect_to request.referer, notice: "カテゴリを削除しました"
  end

  def edit
  end

  def update
    @category.update(category_params)
    redirect_to request.referer, notice: "カテゴリを編集しました"
  end
private
  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def set_index
    @categories = current_user.categories
    @category_new = Category.new
  end

  def is_matching_login_user
    user_id = @category.user_id
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to root_path, alert: '他のユーザーの情報は編集できません。'
    end
  end

end
