class MailController < ApplicationController

  def index
  end

  def send_email
    Email.form_email(params[:to], params[:subject], params[:body]).deliver
  end
end