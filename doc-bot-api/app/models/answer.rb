class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :consultation

  VALID_PROCEDURE_REGEXP = /knee|spine|hip|back/

  YES_ANSWER = 'Yes'
  NO_ANSWER = 'No'

  validate :complaint_must_match_procedures

  def to_procedure_keyword
    value.downcase.match(VALID_PROCEDURE_REGEXP)[0]
  end

  def matching_procedures
    case to_procedure_keyword
    when 'knee'
      Procedure.where(description: 'Knee Replacement')
    when 'hip'
      Procedure.where(description: 'Hip Replacement')
    else
      Procedure.where.not(description: ['Knee Replacement', 'Hip Replacement'])
    end
  end

  private

  def complaint_must_match_procedures
    if question.slug == 'complaint' && !value.downcase.match(VALID_PROCEDURE_REGEXP)
      errors.add(:value, 'must match available procedures')
    end
  end
end
