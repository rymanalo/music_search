require_relative '../spec_helper'

describe MailController do

  describe "send_mail" do

    it "should send email" do
      get :send_email, :to => "12@gmail.com", :subject => "test", :body => "test"
    end

  end

end