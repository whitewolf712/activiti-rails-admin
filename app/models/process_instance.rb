class ProcessInstance < ActivitiAbstractModel
  proxy DataProxy

  get :all,  '/runtime/process-instances'
  get :find, '/runtime/process-instances/:id'
  delete :destroy, '/runtime/process-instances/:id'
end
