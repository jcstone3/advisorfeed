class Usermailer < ActionMailer::Base
  default from: '"Advisor Feed" <advisorfeedtest@gmail.com>'
  def welcome(user)
    # @user = user
    # @url  = "http://www.revenuegrader.com/login"
    # mail(:to => user.email, :subject => "Welcome to Revenue Grader")
  end

  def reset_password_instructions(user)
    # @resource = user
    # mail(:to => @resource.email, :subject => "Reset password instructions", :tag => 'password-reset') do |format|
    #   format.html { render "usermailer/reset_password_instructions" }
    # end
  end
end