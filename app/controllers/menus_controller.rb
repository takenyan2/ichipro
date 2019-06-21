class MenusController < ApplicationController
  def top
  end

  def course
    @menus = Menu.all
    @menu = Menu.new
    @menu.courses.build
  end

  def access
  end

  def note
  end

  def add
    @menu = Menu.new
  end

  def edit_menu
    @menu = Menu.find(params[:id])
  end


  def update_menu
    menu = Menu.find(params[:id])
    if  menu.update#(menu_params)
        flash[:notice] = "保存しました"
        redirect_to course_path
    else
      flash[:danger] = "登録に失敗しました"
        # render :edit_menu
        redirect_to course_path
    end
  end

  def destroy_menu
  end

  def index
  end

  def edit
  end

  def create
    if params[:permission]
      if params[:permission] == "true"
        @menu = Menu.new(menu_params)
        @menu.save
        # flash[:notice] = "保存しました"
      elsif params[:permission] == "false"
        @course = Course.new(course_params)
        @course.save
        # flash[:notice] = "保存しました"
      end
    else
      flash[:danger] = "登録に失敗しました"
    end
    redirect_to course_path
  end

  def update
    menu = Menu.find(params[:id])
    if  menu.update#(menu_params)
        flash[:notice] = "更新しました"
        redirect_to course_path
    else
      flash[:danger] = "更新に失敗しました"
        render :edit_menu
    end
  end

  def destroy
    if params[:permission]
      if params[:permission] == "true"
        menu = Menu.find(params[:id])
        menu.destroy
        flash[:notice] = "削除しました"
      elsif params[:permission] == "false"
        course = Course.find(params[:id])
        course.destroy
        flash[:notice] = "削除しました"
      end
    end
    redirect_to course_path
  end

  private
  def menu_params
    params.require(:menu).permit(:menu_title, :introduce, :menu_image)
  end

  def course_params
    params.require(:menu).permit(:menu_id, [:course_name, :course_time, :price])
  end

end
