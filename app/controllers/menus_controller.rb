class MenusController < ApplicationController
  def top
  end

  def course
    @menus = Menu.all
    @couses = Course.all
  end

  def access
  end

  def note
  end

  def add
    @menu = Menu.new#(menu_params)
  end

  def edit_menu
    @menu = Menu.find(params[:id])
  end

  def create_menu
  end

  def update_menu
    menu = Menu.find(params[:id])
    if  menu.update#(menu_params)
        flash[:notice] = "successfully! 保存しました"
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
    if params[:menu][:permission]
      if params[:menu][:permission] == "true"
        @menu = Menu.new(menu_params)
        @menu.save
        flash[:notice] = "保存しました"
        redirect_to course_path
      elsif params[:menu][:permission] == "false"
        @course = Course.new(course_params)
        @course.save
        flash[:notice] = "保存しました"
        redirect_to course_path
      end
    else
      flash[:danger] = "登録に失敗しました"
      redirect_to course_path
    end
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
  end

  private
  def menu_params
    params.require(:menu).permit(:menu_title, :introduce, :menu_image)
  end

  def course_params
    params.require(:course).permit(:menu_id, :course_name, :course_time, :price)
  end

end
