module ApplicationHelper
  def signed_in?
    !!session[:api_url]
  end

  def activiti_server_name
    URI.parse(session[:api_url]).host
  end

  def profile_urls
    if signed_in?
      user_link = link_to('#', class: 'dropdown-toggle', data: { toggle: 'dropdown' }) do
        concat content_tag :span, nil, class: 'glyphicon glyphicon-user'
        concat " #{session[:api_user]} "
        concat content_tag :b, '', class: 'caret'
      end
      server_info = content_tag :div, class: 'server-info-box' do
        concat content_tag :b, 'Server: '
        concat activiti_server_name
        concat content_tag :br
        concat content_tag :b, 'API version: '
        concat session[:api_version]
      end
      actions_menu = content_tag :ul, class: 'dropdown-menu' do
        concat content_tag :li, server_info
        concat content_tag :li, '', class: 'divider'
        concat content_tag :li, link_to('Log out', signout_path)
      end

      content_tag :li, id: 'fat-menu', class: 'dropdown' do
        concat user_link
        concat actions_menu
      end
    else
      content_tag :li, link_to('Sign in', signin_path)
    end
  end

  def search_box
    if signed_in?
      content_tag :li do
        form_tag search_process_instances_path, class: 'navbar-form', role: 'search', method: :get do
          content_tag :div, class: 'form-group' do
            number_field_tag :id, nil, class: 'form-control search-proc-inst-by-id', placeholder: 'Id of process instance...'
          end
        end
      end
    end
  end
end
