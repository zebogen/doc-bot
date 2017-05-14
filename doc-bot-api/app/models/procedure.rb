class Procedure < ApplicationRecord
  has_many :doctor_procedures
  has_many :doctors, through: :doctor_procedures
end
