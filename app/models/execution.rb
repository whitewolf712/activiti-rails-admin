class Execution < ActivitiAbstractModel
  get     :all,     '/runtime/executions'
  delete  :destroy, '/runtime/executions/:id'
end