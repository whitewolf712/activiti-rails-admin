class DataProxy < ActiveRestClient::ProxyBase
  get '' do
    response = passthrough
    translate(response) do |body|
      body['data'] ? body['data'] : body
    end
  end
end