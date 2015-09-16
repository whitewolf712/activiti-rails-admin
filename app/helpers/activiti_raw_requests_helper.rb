module ActivitiRawRequestsHelper
  def raw_request(url)
    uri = URI(url)
    request = Net::HTTP::Get.new(uri)
    request.basic_auth session[:api_user], session[:api_password]
    response = Net::HTTP.start(uri.hostname, uri.port) {|http|
      http.request(request)
    }

    response.body
  end

  def raw_delete(url)
    uri = URI(url)
    connection = Net::HTTP.new uri.host, uri.port
    request = Net::HTTP::Delete.new uri
    request.basic_auth session[:api_user], session[:api_password]
    connection.request request
  end

  def put_binary_variable_data(url, name, type, data)
    uri = URI(url)
    connection = Net::HTTP.new uri.host, uri.port
    request = Net::HTTP::Put.new uri
    form_data = [
        ['name', name],
        ['type', type],
        ['data', data]
    ]
    request.set_form form_data, 'multipart/form-data'
    request.basic_auth session[:api_user], session[:api_password]
    connection.request request
  end


end
