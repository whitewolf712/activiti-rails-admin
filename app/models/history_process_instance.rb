class HistoryProcessInstance < ActivitiAbstractModel
  proxy DataProxy

  get :all,  '/history/historic-process-instances'
  get :find, '/history/historic-process-instances/:id?includeProcessVariables=true'
  delete :destroy, '/history/historic-process-instances/:id'
end