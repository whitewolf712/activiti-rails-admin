class Job < ActivitiAbstractModel
  before_request :replace_body

  proxy DataProxy

  get :all,       '/management/jobs'
  post :execute,  '/management/jobs/:id'
  delete :remove, '/management/jobs/:id'

  private
  def replace_body(name, request)
    if name == :execute
      request.headers['Content-Type'] = 'application/json'
      request.body = { action: 'execute' }.to_json
    end
  end
end