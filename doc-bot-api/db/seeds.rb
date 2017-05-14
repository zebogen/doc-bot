QUESTION_DATA = [
  {
    text: 'Who are you seeking care for today?',
    answer_type: 'text',
    slug: 'who-is-patient'
  },
  {
    text: 'When do you need care?',
    answer_type: 'text',
    slug: 'when-need'
  },
  {
    text: 'What are you seeking care for today?',
    answer_type: 'text',
    slug: 'complaint'
  },
  {
    text: 'Where are you seeking care?',
    answer_type: 'text',
    slug: 'location'
  },
  {
    text: 'Please name your primary insurance plan.',
    answer_type: 'text',
    slug: 'insurance'
  },
  {
    text: 'Do you have any specific preferences?',
    answer_type: 'boolean',
    slug: 'preferences'
  },
  {
    text: 'Is a doctor in close proximity important to you?',
    answer_type: 'boolean',
    slug: 'doctor-location'
  },
  {
    text: 'Are Yelp ratings important to you?',
    answer_type: 'boolean',
    slug: 'yelp-ratings'
  },
  {
    text: 'Do you prefer a male or female provider?',
    answer_type: 'text',
    slug: 'provider-gender'
  },
  {
    text: 'Do you prefer a doctor with many years of experience?',
    answer_type: 'boolean',
    slug: 'experience'
  }
]

QUESTION_DATA.each_with_index do |question, index|
  Question.create!(question.merge(sequence_number: index + 1))
end
