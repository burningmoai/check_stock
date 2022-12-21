class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[destroy update]

  def index
    @categories = current_user.categories
    @category_new = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id
    @category.save
    redirect_to categories_path, notice: "カテゴリが新規登録されました"
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
end
