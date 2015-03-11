module ProcessJobsHelper
  def job_execute_tag(job_id)
    form_tag process_job_path(id: job_id), method: :put do
      button_tag(type: 'submit', class: 'btn btn-default') do
        '<span class="glyphicon glyphicon-send" aria-hidden="true"></span> Execute</button>'.html_safe
      end
    end
  end

  def job_delete_tag(job_id)
    form_tag process_job_path(id: job_id), method: :delete do
      button_tag(type: 'submit', class: 'btn btn-default', data: { confirm: 'Are you sure?' } ) do
        '<span class="glyphicon glyphicon-trash" aria-hidden="true"></span> Remove</button>'.html_safe
      end
    end
  end
end
