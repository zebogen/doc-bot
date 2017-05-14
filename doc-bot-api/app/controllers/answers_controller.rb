class AnswersController < ApplicationController
  def create
    consultation = Consultation.find_by(facebook_id: params[:facebook_id])
    if consultation
      answer = consultation.answers.create!(answer_params.merge(question_id: question.id))
      consultation.update!(current_sequence_number: consultation.current_sequence_number + 1)
    else
      consultation = Consultation.create!(facebook_id: params[:facebook_id])
    end

    render json: Question.find_by!(sequence_number: consultation.current_sequence_number)
  end

  private

  def consultation
    Consultation.where(facebook_id: params[:facebook_id]).latest.first
  end

  def question
    Question.find_by!(sequence_number: consultation.current_sequence_number)
  end

  def answer_params
    params.permit(:value)
  end
end
