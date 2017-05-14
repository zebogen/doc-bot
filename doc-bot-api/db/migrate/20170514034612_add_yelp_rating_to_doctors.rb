class AddYelpRatingToDoctors < ActiveRecord::Migration[5.1]
  def change
    add_column :doctors, :yelp_rating, :decimal
  end
end
