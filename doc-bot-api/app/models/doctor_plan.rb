class DoctorPlan < ApplicationRecord
  belongs_to :doctor
  belongs_to :plan
end
