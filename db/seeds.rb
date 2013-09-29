#Basic cms pages
site = Cms::Site.create!(
  identifier: 'gamedev',
  label: 'gamedev',
  hostname: 'localhost:3000'
)

events_layout = site.layouts.create!(
  identifier: 'events',
  app_layout: 'events',
  content: "{{cms:page:content:rich_text}}"
)

events_layout.pages.create! label: 'homepage', slug: '', site: site

#test user account
user = User.create! email: 'test@example.com', password: 'test12345'
user.add_role :admin
