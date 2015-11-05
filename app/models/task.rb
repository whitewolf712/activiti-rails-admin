class Task < ActivitiAbstractModel
  base_url @api_url

  get :all,  '/runtime/tasks'
end
