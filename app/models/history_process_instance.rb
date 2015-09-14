class HistoryProcessInstance < ActivitiAbstractModel
  get :all,  '/history/historic-process-instances'
  get :find, '/history/historic-process-instances/:id?includeProcessVariables=true'
  delete :destroy, '/history/historic-process-instances/:id'

  def self.paginate(method_sym, method_options = {}, paginate_options = {})
    method   = self.method(method_sym)
    page     = paginate_options[:page] ? paginate_options[:page].to_i : 1
    per_page = WillPaginate.per_page

    method_options[:start] ||= page * per_page - per_page
    method_options[:size]  ||= per_page
    result   = method.call method_options
    total    = result.total || result.to_a.length

    WillPaginate::Collection.create(page, per_page, total) do |pager|
      pager.replace result.data.to_a
    end
  end
end
