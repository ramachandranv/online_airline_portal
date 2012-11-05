class CreateEnquiries < ActiveRecord::Migration
  def change
    create_table :enquiries do |t|
      t.string :airline_company
      t.string :source
      t.string :destination
      t.string :date
      t.string :number_of_persons
      t.text :passenger_details
      t.references :user

      t.timestamps
    end
  end
end
