PicShare::Application.configure do
  config.eager_load = false
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
#  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default :charset => "utf-8"
  config.action_mailer.smtp_settings = {
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => 'pictcollect.link',
  :user_name => ENV["GMAIL_USERNAME"],
  :password => ENV["GMAIL_PASSWORD"],
  :authentication => 'plain',
  :enable_starttls_auto => true
  }
  config.sendmail_settings = {
    :location => '/usr/sbin/postfix'
  }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers

  # Raise exception on mass assignment protection for Active Record models

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)

  # Do not compress assets
  config.assets.js_compressor = false

  # Expands the lines which load the assets
  config.assets.debug = true
end
