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
    if @enquiry.save
      EnquiryMailer.send_enquiry(current_user, @enquiry).deliver!
      redirect_to enquiries_path, :notice => "Enquiry created successfully"
    else
      render 'new'
    end
  end
end
