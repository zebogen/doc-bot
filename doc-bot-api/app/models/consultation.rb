class Consultation < ApplicationRecord
  has_many :answers

  scope :latest, -> { order(created_at: :desc) }

  def candidate_procedures
    answers.includes(:question).where(questions: { slug: 'complaint' }).first.matching_procedures
  end

  def plans
    Plan.where('name LIKE ?', "%#{answers.includes(:question).where(questions: { slug: 'insurance' }).first.value.downcase}%")
  end

  def recommendation_factors
    if answers.no.includes(:question).where(questions: { slug: 'preferences' }).exists?
      Question::RECOMMENDATION_FACTOR_SLUGS
    else
      answers.yes.includes(:question).where(questions: { slug: Question::RECOMMENDATION_FACTOR_SLUGS }).map do |answer|
        answer.question.slug
      end
    end
  end

  def gender_preference
    answers.includes(:question).where(questions: { slug: 'provider-gender' }).first.try(:value)
  end
end
