class Email < ActionMailer::Base
  default from: "12manalo@gmail.com"

  def form_email(to, subject, body)
    @body = body
    mail(:to => to, :subject => subject)
  end

end
