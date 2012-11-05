class EnquiryMailer < ActionMailer::Base
  default from: "v.ramcool.ramachandran@gmail.com"

  def send_enquiry(user, enquiry)
    @user = user
    @enquiry = enquiry
    mail(:to => 'vramachandran86@gmail.com', :subject => 'Online booking enquiry')
  end
end
