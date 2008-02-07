class UserMailer < ActionMailer::Base
  include ActionController::UrlWriter
  default_url_options[:host] = ApplicationConfig::HOST

  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
    @body[:url]  = url_for(:controller => "users", :action => :activate, :activation_code => user.activation_code)
  end

  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = url_for(:controller => "/")
  end

  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = ApplicationConfig::ADMIN_MAIL
      @subject     = "[%s] " % ApplicationConfig::SITE_NAME
      @sent_on     = Time.now
      @body[:user] = user
    end
end