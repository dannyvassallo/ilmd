class PostMailer < ActionMailer::Base
  def posted_confirmation(micropost)
    @micropost = micropost
    mail :to => "dan@trendsettermarketing.net, danielvassallo87@gmail.com", :from => "noreply@ilovemydoctor.com", :subject => "ILMD: Someone Posted a Note!"
  end
end
