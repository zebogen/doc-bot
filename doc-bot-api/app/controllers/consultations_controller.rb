class ConsultationsController < ApplicationController
  def create
    consultation = Consultation.create!(facebook_id: params[:facebook_id])
    render json: Question.find_by!(sequence_number: 1)
  end

  private

  def consultation_params
    params.permit(:facebook_id)
  end
end
