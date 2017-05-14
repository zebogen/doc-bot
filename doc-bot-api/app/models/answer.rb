class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :consultation

  VALID_PROCEDURE_REGEXP = /knee|spine|hip|back/

  TRUE_ANSWER = 'Yes'
  FALSE_ANSWER = 'No'

  validate :complaint_must_match_procedures

  private

  def complaint_must_match_procedures
    if question.slug == 'complaint' && !value.downcase.match(VALID_PROCEDURE_REGEXP)
      errors.add(:value, 'must match available procedures')
    end
  end
end
