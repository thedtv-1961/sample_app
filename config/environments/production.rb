Rails.application.configure do
  config.cache_classes = true

  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  config.assets.js_compressor = :uglifier

  config.assets.compile = false

  config.active_storage.service = :local

  config.log_level = :debug

  config.log_tags = [ :request_id ]

  config.action_mailer.perform_caching = false

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.action_mailer.perform_deliveries = true

  config.action_mailer.default_url_options = { host: ENV["mail_host"],
    protocol: ENV["mail_protocol"] }

  config.active_record.dump_schema_after_migration = false

  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    address: ENV["mail_server"],
    port: ENV["mail_post"],
    user_name: ENV["mail_username"],
    password: ENV["mail_password"],
    authentication: ENV["mail_authentication"],
    enable_starttls_auto: ENV["mail_enable_starttls_auto"]
  }

  # config.file_watcher = ActiveSupport::EventedFileUpdateChecker
  # config.middleware.use I18n::JS::Middleware
end
