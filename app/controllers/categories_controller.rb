class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @category_new = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to categories_path, notice: "カテゴリが新規登録されました"
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    redirect_to request.referer, notice: "カテゴリを削除しました"
  end

  def edit
  end

  def update
    category = Category.find(params[:id])
    category.update(category_params)
    redirect_to request.referer, notice: "カテゴリを編集しました"
  end
private
  def category_params
    params.require(:category).permit(:name)
  end
end
