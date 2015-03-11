class ProcessVariable < ActivitiAbstractModel
  before_request :replace_body

  base_url @api_url
  get :all,  '/runtime/process-instances/:process_instance_id/variables'
  get :find, '/runtime/process-instances/:process_instance_id/variables/:name'
  put :save, '/runtime/process-instances/:process_instance_id/variables'

  private
  def replace_body(name, request)
    if name == :save
      @var = request.object
      int_types = %w(integer short long)
      value = @var.value.to_s # Works for String and Date
      value = @var.value.to_i if int_types.include? @var.type
      value = @var.value.to_f if @var.type == 'double'
      value = @var.value == 'true' if @var.type == 'boolean'
      # TODO: binary and serializable implementations
      request.body = [ { name: @var.name,
                         type: @var.type,
                         value: value } ].to_json
    end
  end
end
