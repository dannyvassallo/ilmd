$(function(){
      // FACEBOOK //

      // FB ON CLICK //
      $(".fb-share").on("click", fb_ui);

      function getIDFromButton($button) {
        return $button.closest(".micropost").data("id");
      }

      window.fbAsyncInit = function() {
        // init the FB JS SDK
        FB.init({
          appId      : window.fbAppId, // App ID from the App Dashboard
          //channelUrl : '//WWW.YOUR_DOMAIN.COM/channel.html', // Channel File for x-domain communication
          status     : true, // check the login status upon init?
          cookie     : true, // set sessions cookies to allow your server to access the session?
          xfbml      : true  // parse XFBML tags on this page?
        });
      };

      // Load the SDK Asynchronously
      function fb_ui(e) {
        e.preventDefault();
        var $btn = $(this);

      //SHARE URL//
        var url = window.location.host
          , path = "/microposts/"
          , postid = getIDFromButton($btn)
          , fin;

          fin = url + path + postid;
      
      $('.fb-share').on('click', function(){
        alert(fin)
      });

        // Additional initialization code such as adding Event Listeners goes here
        FB.ui(
          {
            method: 'feed',
            name: 'I Love My Doctor', // name of the product or content you want to share
            link: fin, // link back to the product or content you are sharing
            picture: 'https://s3.amazonaws.com/myfangate.com/ilovemydoctor/ilmdfbshareimage.jpg', // path to an image you would like to share with this content
            caption: 'Saint Barnabas | I Love My Doctor', // caption
            description: 'Let your doctor know how much you care! Leave a them a note today!' // description of your product or content
          },
          function(response) {
            if (response && response.post_id) {
              track('facebook-share', 'success');
              alert('Thanks for sharing!');
            } else {
              track('facebook-share', 'fail');
              alert('Sorry! There was an error publishing your post. Please Try again.');
            }
          }
        );

      }


      (function(d){
      var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
      if (d.getElementById(id)) {return;}
      js = d.createElement('script'); js.id = id; js.async = true;
      js.src = "//connect.facebook.net/en_US/all.js";
      ref.parentNode.insertBefore(js, ref);
      }(document));



});
