class EnquiriesController < ApplicationController
  before_filter :authenticate_user!
  def index
    @enquiries = current_user.enquiries.order('created_at DESC').page(params[:page]).per(5)
  end

  def new
    @enquiry = Enquiry.new
  end

  def create
    params[:enquiry][:return_time] = "" if (params[:enquiry][:trip_type] == "One way")
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

  def show
    @enquiry = Enquiry.find(params[:id])
  end
end
