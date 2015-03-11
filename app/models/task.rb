class Task < ActivitiAbstractModel
  proxy DataProxy
  base_url @api_url

  get :all,  '/runtime/tasks'
end
