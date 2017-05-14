class Consultation < ApplicationRecord
  has_many :answers

  scope :latest, -> { order(created_at: :desc) }
end
