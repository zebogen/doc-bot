class Question < ApplicationRecord
  RECOMMENDATION_FACTOR_SLUGS = %w(doctor-location yelp-ratings provider-gender experience)

  scope :in_sequence, -> { order(:sequence_number) }

  def last?
    id == Question.in_sequence.last.id
  end
end
