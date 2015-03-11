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
end