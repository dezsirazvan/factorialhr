# frozen_string_literal: true

Apipie.configure do |config|
  config.app_name                = 'Factorial HR'
  config.api_base_url            = '/api/v1'
  config.doc_base_url            = '/apipie'
  config.translate               = false
  config.validate                = false
  config.namespaced_resources    = true
  config.api_controllers_matcher = Rails.root.join('app', 'controllers', 'api', '**', '*.rb')
  config.show_all_examples       = true
  config.default_locale = nil
end
