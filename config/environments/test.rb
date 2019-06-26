Rails.application.configure do
  config.cache_classes = true

  config.eager_load = false

  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{1.hour.to_i}"
  }

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.action_dispatch.show_exceptions = false

  config.action_controller.allow_forgery_protection = false

  config.active_storage.service = :test

  config.action_mailer.perform_caching = false

  config.action_mailer.delivery_method = :test

  config.active_support.deprecation = :stderr

  config.action_mailer.default_url_options = { host: ENV["mail_host"],
                                               protocol: ENV["mail_protocol"] }
  config.action_mailer.smtp_settings = {
      address: ENV["mail_server"],
      port: ENV["mail_post"],
      user_name: ENV["mail_username"],
      password: ENV["mail_password"],
      authentication: ENV["mail_authentication"],
      enable_starttls_auto: ENV["mail_enable_starttls_auto"]
  }


end
