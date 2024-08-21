class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    if params[:id] == 'result'
      result
      render :result
    else
      @question = Question.find(params[:id])
    end
  end

  def check_answers
    user_answers = params[:user_answers]
    questions = Question.all
    score = 0
    correct_answers = []

    questions.each do |question|
      user_answer = user_answers[question.id.to_s]
      correct_answer = question.correct_answer.split(',')

      if user_answer.is_a?(Array)
        user_answer = user_answer.sort
        correct_answer = correct_answer.sort
      else
        user_answer = [user_answer].compact
      end

      if user_answer == correct_answer
        score += 1
      end

      correct_answers << { id: question.id, correct_answer: question.correct_answer }
    end

    render json: { score: score, total: questions.count, correct_answers: correct_answers }
  end

  def submit_answers
    user_answers = JSON.parse(params[:user_answers])
    session[:user_answers] = user_answers
    session[:score] = calculate_score(user_answers)
    redirect_to questions_result_path
  end

  def result
    @user_answers = session[:user_answers]
    @score = session[:score]
    @questions = Question.all
    render :result
  end

  private

  def calculate_score(user_answers)
    score = 0
    Question.all.each do |question|
      user_answer = user_answers[question.id.to_s]
      correct_answer = question.correct_answer.split(',')

      if user_answer.is_a?(Array)
        user_answer = user_answer.sort
        correct_answer = correct_answer.sort
      else
        user_answer = [user_answer].compact
      end

      score += 1 if user_answer == correct_answer
    end
    score
  end
end