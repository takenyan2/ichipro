class QuestionsController < ApplicationController
  
  def index
    @question = Question.new
    @questions = Question.all
  end
  
  def create
    question = Question.new(question_params)
    if question.save
      flash[:success] = "登録しました。"
      redirect_to questions_path
    else
      flash[:danger] = "登録に失敗しました。"
      redirect_to questions_path
    end
  end
  
  def edit
    @question = Question.find(params[:id])
  end
  
  def update
    @question = Question.find(params[:id])
    if  @question.update(question_params)
        flash[:success] = "更新しました。"
        redirect_to questions_path
    else
      flash[:danger] = "更新に失敗しました。"
        render :edit
    end
  end
  
  def destroy
    question = Question.find(params[:id])
    if question.destroy
      flash[:success] = "削除しました。"
    else
      flash[:danger] = "削除に失敗しました。"
    end
    redirect_to questions_path
  end
  
  private
  
  def question_params
    params.require(:question).permit(:user_question, :answer)
  end
  
end