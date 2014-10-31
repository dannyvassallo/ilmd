class PostMailer < ActionMailer::Base
  def posted_confirmation(micropost)
    @micropost = micropost
    mail :to => ENV['NOTE_EMAIL'], :from => "noreply@ilovemydoctor.com", :subject => "ILMD: Someone Posted a Note!"
  end
end
