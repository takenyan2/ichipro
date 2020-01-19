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
    @question = Question.new
    @questions = Question.all
  end

  def create_note
    question = Question.new(question_params)
    if question.save
      flash[:success] = "登録しました。"
      redirect_to note_path
    else
      flash[:danger] = "登録に失敗しました。"
      redirect_to note_path
    end
  end

  def edit_note
    @question = Question.find(params[:id])
  end

  def update_note
    @question = Question.find(params[:id])
    if  @question.update(question_params)
        flash[:success] = "更新しました。"
        redirect_to note_path
    else
      flash[:danger] = "更新に失敗しました。"
        render :edit_note
    end
  end

  def destroy_note
    question = Question.find(params[:id])
    if question.destroy
      flash[:success] = "削除しました。"
    else
      flash[:danger] = "削除に失敗しました。"
    end
    redirect_to note_path
  end

  def add
    @menu = Menu.new
  end

  def edit_menu
    @menu = Menu.find(params[:id])
  end


  def update_menu
    menu = Menu.find(params[:id])
    if  menu.update(menu_params)
        flash[:success] = "更新しました。"
    else
      flash[:danger] = "更新に失敗しました。"
        render :edit
    end
    redirect_to course_path
  end

  def destroy_menu
  end

  def edit
    @course = Course.find(params[:id])
  end

  def create
      if params[:permission] == "true"
        @menu = Menu.new(menu_params)
        # byebug
        if @menu.save
          flash[:success] = "登録しました。"
          redirect_to course_path
        else
          flash[:danger] = "登録に失敗しました。"
          render :add
        end
      elsif params[:permission] == "false"
        @course = Course.new(menu_course_params)
        if @course.save
          flash[:success] = "登録しました。"
          redirect_to course_path
        else
          flash[:danger] = "同じメニュー内にコース名が重複しているため、登録に失敗しました。"
          redirect_to course_path
        end
      end
  end

  def update
    # byebug
    if params[:permission] == "true"
      @menu = Menu.find(params[:id])
      if @menu.update(menu_params)
          flash[:success] = "更新しました。"
          redirect_to course_path
      else
        flash[:danger] = "更新に失敗しました。"
        render :edit_menu
      end
    elsif params[:permission] == "false"
      @course = Course.find(params[:id])
      if @course.update(course_params)
          flash[:success] = "更新しました。"
          redirect_to course_path
      else
        flash[:danger] = "更新に失敗しました。"
          render :edit
      end
    end
  end

  def destroy
    if params[:permission]
      if params[:permission] == "true"
        menu = Menu.find(params[:id])
        menu.destroy
        flash[:sccess] = "削除しました。"
      elsif params[:permission] == "false"
        course = Course.find(params[:id])
        course.destroy
        flash[:danger] = "削除しました。"
      end
    end
    redirect_to course_path
  end

  private
  def menu_params
    params.require(:menu).permit(:menu_title, :introduce, :image)
  end

  def menu_course_params
    params.require(:menu).permit(:menu_id, [:course_name, :course_time, :price])
  end

  def course_params
    params.require(:course).permit(:course_name, :course_time, :price)
  end

  def question_params
    params.require(:question).permit(:user_question, :answer)
  end

end
