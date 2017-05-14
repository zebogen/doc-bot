INSURANCES_ENDPOINT = 'https://api.betterdoctor.com/2016-03-01/insurances'

task fetch_insurer_data: :environment do
  insurers = HTTParty.get("#{INSURANCES_ENDPOINT}?user_key=#{Rails.application.secrets.better_doctor_api_key}").parsed_response['data']
  puts "Found #{insurers.length} insurers"
  insurers.each do |insurer|
    created_insurer = Insurer.create!(uid: insurer['uid'], name: insurer['name'])
    puts "Created insurer record #{created_insurer.id} for #{insurer['name']}"
    insurer['plans'].each do |plan|
      next if plan['category'] != ['medical']
      created_insurer.plans.create!(uid: plan['uid'], name: plan['name'])
      puts "Created plan record for #{plan['name']}"
    end
  end
end
