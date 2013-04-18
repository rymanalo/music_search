OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['fb_key'], ENV['fb_secret'], :scope => 'email,user_birthday,read_stream', :display => 'popup'
end