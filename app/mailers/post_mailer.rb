class PostMailer < ActionMailer::Base
  def posted_confirmation(user)
    @user = user
    mail :to => "dan@trendsettermarketing.net, danielvassallo87@gmail.com", :from => "noreply@ilovemydoctor.com", :subject => "Someone Posted a Note!"
  end
end
