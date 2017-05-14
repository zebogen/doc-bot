class Consultation < ApplicationRecord
  has_many :answers

  scope :latest, -> { order(created_at: :desc) }

  def candidate_procedures
    answers.includes(:question).where(questions: { slug: 'complaint' }).first.matching_procedures
  end

  def plans
    Plan.where('name LIKE ?', "%#{answers.includes(:question).where(questions: { slug: 'insurance' }).first.value.downcase}%")
  end
end
