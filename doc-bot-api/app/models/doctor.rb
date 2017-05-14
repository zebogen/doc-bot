class Doctor < ApplicationRecord
  has_many :doctor_specializations
  has_many :specializations, through: :doctor_specializations

  has_many :doctor_procedures
  has_many :procedures, through: :doctor_procedures

  has_many :doctor_plans
  has_many :plans, through: :doctor_plans
end
