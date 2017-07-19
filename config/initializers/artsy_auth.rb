ArtsyAuth.configure do |config|
  config.artsy_api_url = ENV['ARTSY_WEB_URL']
  config.application_id = ENV['ARTSY_APP_ID']
  config.application_secret = ENV['ARTSY_APP_SECRET']
end
