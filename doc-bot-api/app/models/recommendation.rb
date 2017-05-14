class Recommendation
  DEFAULT_SIZE = 3

  def initialize(consultation:, size: DEFAULT_SIZE)
    @consultation = consultation
    @size = size
  end

  SORT_FUNCTIONS_BY_SLUG = {
    'doctor-location' => ->(a, b) { b.distance <=> a.distance },
    'yelp-ratings' => ->(a, b) { a.yelp_rating.to_f <=> b.yelp_rating.to_f },
    'experience' => ->(a, b) { a.last_degree_year.to_i <=> b.last_degree_year.to_i }
  }

  def generate
    doctors_for_complaint.sort_by do |doc|
      gender_score = doc.gender && @consultation.gender_preference.downcase == doc.gender ? doctors_for_complaint.length : 0
      gender_score + sort_score(doc, 'doctor-location') + sort_score(doc, 'yelp-ratings') + sort_score(doc, 'experience') + sort_score(doc, 'complications')
    end.last(@size)
  end

  private

  def sort_score(doc, slug)
    sorted_lists.key?(slug) ? sorted_lists[slug].find_index { |d| d.id == doc.id } : 0
  end

  def sorted_lists
    @sorted_lists ||= begin
      @consultation.recommendation_factors.each_with_object({}) do |factor, sorted_lists|
        next unless SORT_FUNCTIONS_BY_SLUG.key?(factor)
        sorted_lists[factor] = doctors_for_complaint.sort(&SORT_FUNCTIONS_BY_SLUG[factor])
      end.merge(
        'complications' => doctors_for_complaint.sort do |a, b|
          b.average_complication_rate <=> a.average_complication_rate
        end
      )
    end
  end

  def doctors_for_complaint
    @doctors_for_complaint ||= begin
      Doctor
        .includes(:procedures, :plans)
        .where(procedures: { id: @consultation.candidate_procedures.pluck(:id) })
        .where(plans: { id: @consultation.plans.pluck(:id) })
    end
  end
end
