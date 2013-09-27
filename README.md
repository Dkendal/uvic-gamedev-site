#UVIC GAME DEV (web site)
A rails 4 app for Uvic Game Dev group!

##Set up
A facebook app is required to make api calls to facebook (used to query events). Go sign up for an app on facebook then create a file `./.env` based on the [example file](.env.example) No special rake tasks required: `rake db:setup`

This site uses [Comfy Mexican Sofa](https://github.com/comfy/comfortable-mexican-sofa) as a cms, so you will need to create a new site. The cms_admin path is mounted at ``` admin/cms ```.
