class PostNotification < ActionMailer::Base
     default :from => "noreply@ilovemydoctor.com"

   def post_email(user)
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
   end
 end
