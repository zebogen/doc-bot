class Recommendation
  DEFAULT_SIZE = 3

  def initialize(consultation:, size: DEFAULT_SIZE)
    @consultation = consultation
    @size = size
  end

  def generate
    factors = @consultation.recommendation_factors
    sorted_lists = factors.each_with_object({}) do |factor, sorted_lists|
      case factor
      when 'doctor-location'
        sorted_lists[factor] = doctors_for_complaint.sort { |a, b| b.distance <=> a.distance }
      when 'yelp-ratings'
        sorted_lists[factor] = doctors_for_complaint.sort { |a, b| a.yelp_rating.to_f <=> b.yelp_rating.to_f }
      when 'experience'
        sorted_lists[factor] = doctors_for_complaint.sort { |a, b| a.last_degree_year.to_i <=> b.last_degree_year.to_i }
      end
    end.compact
    doctors_for_complaint.sort_by do |doc|
      gender_score = doc.gender && @consultation.gender_preference == doc.gender ? doctors_for_complaint.length : 0
      location_score = sorted_lists.key?('doctor-location') ? sorted_lists['doctor-location'].find_index { |d| d.id == doc.id } : 0
      ratings_score = sorted_lists.key?('yelp-ratings') ? sorted_lists['yelp-ratings'].find_index { |d| d.id == doc.id } : 0
      experience_score = sorted_lists.key?('experience') ? sorted_lists['experience'].find_index { |d| d.id == doc.id } : 0
      gender_score + location_score + ratings_score + experience_score
    end.last(@size)
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
