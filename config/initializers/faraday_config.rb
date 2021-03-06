ActiveRestClient::Base.faraday_config do |faraday|
  faraday.adapter(:patron)
  faraday.options.timeout       = 300
  faraday.headers['User-Agent'] = 'ActivitiRailsAdmin/1.0.0'
  faraday.headers['Connection'] = 'Keep-Alive'
  faraday.headers['Accept'] = 'application/json'
end
