class CreateEnquiries < ActiveRecord::Migration
  def change
    create_table :enquiries do |t|
      t.string  :trip_type
      t.string  :source
      t.string  :destination
      t.date    :departure_date
      t.date    :return_date
      t.integer :adults
      t.integer :children
      t.integer :infants
      t.string  :class_of_travel
      t.string  :airline_preference
      t.string  :departure_time
      t.string  :return_time
      t.text    :passenger_details
      t.references :user

      t.timestamps
    end
  end
end
