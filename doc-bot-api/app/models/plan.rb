class Plan < ApplicationRecord
  belongs_to :insurer

  has_many :doctor_plans
  has_many :plans, through: :doctor_plans
end
