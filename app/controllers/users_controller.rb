class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  before_action :set_user, only: %i[show edit update]
  before_action :is_matching_login_user, only: %i[edit update]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id),notice: "変更が保存されました!"
    else
      render :edit
    end
  end

private
  def user_params
    params.require(:user).permit(:name, :email)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , alert: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to root_path, alert: '他のユーザーの情報は編集できません。'
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
