uvic-gamedev-site
=================
A rails 4 app for Uvic Game Dev group!

Set up
======
Facebook omni auth is used for user authentication so make sure you set the app id and secret through evniroment variables. As well make sure to run the rails server on whatever port you have configured your callbacks for in the facebook app.

``` sh
~ export FACEBOOK_ID=$your_app_id
~ export FACEBOOK_SECRET=$your_app_secret
~ rails s -p 3000
```