class HomesController < ApplicationController
  skip_before_action :authenticate_user!
  # ログイン前でもトップページが見れる

  def top
  end

  def about
  end
end
