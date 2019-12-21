class AdminsController < ApplicationController
  before_action :logged_out_user, only: [:new]
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    @session = user
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'ログインしました。'
      redirect_to root_url
    else
      flash.now[:danger] = '認証に失敗しました。'
      render :new
    end
  end
  
  def destroy
    # ログイン中の場合のみログアウト処理を実行します。
    log_out if logged_in?
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
# beforeアクション

  # ログアウトユーザーか確認
    def logged_out_user
      if logged_in?
        redirect_to root_path
      end
    end
end
