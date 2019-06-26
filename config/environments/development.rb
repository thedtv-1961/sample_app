Rails.application.configure do

  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local = true

  if Rails.root.join("tmp", "caching-dev.txt").exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.active_storage.service = :local

  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.perform_deliveries = true

  config.action_mailer.default_url_options = { host: ENV["mail_host"],
    protocol: ENV["mail_protocol"] }

  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    address: ENV["mail_server"],
    port: ENV["mail_post"],
    user_name: ENV["mail_username"],
    password: ENV["mail_password"],
    authentication: ENV["mail_authentication"],
    enable_starttls_auto: ENV["mail_enable_starttls_auto"]
  }

  config.action_mailer.perform_caching = false

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.active_record.verbose_query_logs = true

  config.assets.debug = true

  config.assets.quiet = true

  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
