class Enquiry < ActiveRecord::Base
  serialize :passenger_details

  attr_accessible :trip_type, :source, :destination, :departure_date, :return_date, :adults, :children, :infants, 
                  :class_of_travel, :airline_preference, :departure_time, :return_time, :passenger_details

  validates_presence_of :source, :destination, :departure_date

  validate :departure_return_date 

  belongs_to :user

  def departure_return_date
    if (self.trip_type == "Round trip") and (self.departure_date > self.return_date)
      errors.add(:return_date, "Return date cannot be less than Departure date")
    end  
  end
end
