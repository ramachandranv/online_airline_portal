class Enquiry < ActiveRecord::Base
  serialize :passenger_details

  attr_accessible :airline_company, :date, :destination, :number_of_persons, :passenger_details, :source

  validates_presence_of :airline_company, :date, :destination, :number_of_persons, :passenger_details, :source

  belongs_to :user
end
