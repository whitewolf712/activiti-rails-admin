ActiveRestClient::Base.faraday_config do |faraday|
  faraday.adapter(:net_http)
  faraday.options.timeout       = 300
  faraday.headers['User-Agent'] = 'ActivitiRailsAdmin/1.0.0'
end