class EnquiryMailer < ActionMailer::Base
  default from: "notifymailer@gmail.com"

  def send_enquiry(user, enquiry)
    @user = user
    @enquiry = enquiry
    mail(:to => ['vramachandran86@gmail.com', 'v.ramcool.ramachandran@gmail.com'], :subject => 'Airline Enquiry')
  end
end
