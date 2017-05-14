class Recommendation
  DEFAULT_SIZE = 3

  def initialize(consultation:, size: DEFAULT_SIZE)
    @consultation = consultation
    @size = size
  end

  def generate
    doctors_for_complaint.first(@size)
  end

  private

  def doctors_for_complaint
    @doctors_for_complaint ||= begin
      Doctor
        .includes(:procedures, :plans)
        .where(procedures: { id: @consultation.candidate_procedures.pluck(:id) })
        .where(plans: { id: @consultation.plans.pluck(:id) })
    end
  end
end
