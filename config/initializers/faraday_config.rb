ActiveRestClient::Base.faraday_config do |faraday|
  faraday.options.timeout       = 120
  faraday.headers['User-Agent'] = 'ActivitiRailsAdmin/1.0.0'
end
