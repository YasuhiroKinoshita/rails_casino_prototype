Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Settings.twitter.consumer_key, Settings.twitter.consumer_secret
  provider :facebook, Settings.facebook.key, Settings.facebook.secret
  provider :slack, Settings.slack.client_id, Settings.slack.client_secret, scope: 'read'
end
