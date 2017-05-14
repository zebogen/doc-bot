task import_yelp_ratings: :environment do
  CSV.foreach('db/data_files/yelp_ratings.csv', headers: true) do |row|
    begin
      Doctor.find_by!(npi: row['npi']).update!(yelp_rating: row['rating'])
    rescue ActiveRecord::RecordNotFound => e
      puts e
    end
  end
end
