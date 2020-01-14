class AdminsController < ApplicationController
  def index
  end

  # deviseのnewではなく、こちらのアクションを呼び出す
  def new
    @admin = Admin.new
  end

  # deviseのcreateではなく、こちらのアクションを呼び出す
  def generate
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to top_url, flash: { success: '管理者を登録しました。' }
    else
      flash.now[:danger] = '登録に失敗しました。'
      # params[:action] = :new
      render 'new', status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def admin_params
    params.require(:admin).permit(:admin_name, :email, :password, :password_confirmation)
  end
end
