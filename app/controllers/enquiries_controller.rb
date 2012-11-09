class EnquiriesController < ApplicationController
  before_filter :authenticate_user!
  def index
    @enquiries = current_user.enquiries
  end

  def new
    @enquiry = Enquiry.new
  end

  def create
    @enquiry = current_user.enquiries.build(params[:enquiry])
    passenger_details = []
    params[:passenger_details].each do |passenger|
      passenger_details << JSON.parse(passenger)
    end
    @enquiry.passenger_details = passenger_details
    if @enquiry.save
      EnquiryMailer.send_enquiry(current_user, @enquiry).deliver!
      redirect_to enquiries_path, :notice => "Enquiry created successfully"
    else
      flash.now[:alert] = @enquiry.errors.full_messages.join('; ')
      render 'new'
    end
  end
end
