class Enquiry < ActiveRecord::Base
  serialize :passenger_details

  attr_accessible :trip_type, :source, :destination, :departure_date, :return_date, :adults, :children, :infants, 
                  :class_of_travel, :airline_preference, :departure_time, :passenger_details

  validates_presence_of :source, :destination, :departure_date

  belongs_to :user
end
