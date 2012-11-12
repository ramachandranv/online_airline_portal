class EnquiryMailer < ActionMailer::Base
  default from: "notifymailer@gmail.com"

  def send_enquiry(user, enquiry)
    @user = user
    @enquiry = enquiry
    mail(:to => ['vramachandran86@gmail.com', 'shalin@tenmiles.com', 'anand@tenmiles.com'], :subject => 'Airline Booking Enquiry')
  end
end
