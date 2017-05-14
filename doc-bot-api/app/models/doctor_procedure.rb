class DoctorProcedure < ApplicationRecord
  belongs_to :doctor
  belongs_to :procedure
end
