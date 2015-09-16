module ProcessInstancesHelper
  def variable_tag(process_instance, variable)
    is_history = !!process_instance.endTime

    if %w(serializable binary).include? variable.type
      return is_history ? history_variable_data_tag(process_instance.id, variable.name) :
          variable_data_tag(process_instance.id, variable.name)
    end
    return variable.value.to_s if is_history
    variable_edit_tag(process_instance.id, variable.name, variable.value)
  end

  def variable_data_tag(proc_inst_id, name)
    content_tag :div do
      concat link_to 'Get binary data', data_process_variable_path(id: proc_inst_id, name: name)
      concat ' | '
      concat link_to 'Upload binary data', '#', class: 'upload_binary_data_link'
      concat variable_data_form(proc_inst_id, name)
    end
  end

  def variable_data_form(proc_inst_id, name)
    form_tag update_binary_process_variable_path(id: proc_inst_id, name: name), method: :put, multipart: true do
      file_field_tag :file,
                     onchange:'javascript:this.form.submit();',
                     style: 'display: none;'
    end
  end

  def history_variable_data_tag(proc_inst_id, name)
    link_to 'Get binary data', data_history_process_variable_path(id: proc_inst_id, name: name)
  end

  def variable_edit_tag(proc_inst_id, name, value = nil)
    link_to value.to_s, '#',
            class: 'editable variable-editable',
            data: { name: 'value',
                    pk: 'variable',
                    url: process_variable_path(id: proc_inst_id, name: name),
                    title: "Enter value for #{name}",
                    value: value.to_s,
                    type: 'text'
                  }
  end

  def process_instance_delete_tag(id)
    form_tag process_instance_path(id: id), method: :delete do
      button_tag(type: 'submit', class: 'btn btn-default btn-lg', data: { confirm: 'Are you sure?' } ) do
        content_tag :span, class: 'glyphicon glyphicon-trash' do
          ' Remove'
        end
      end
    end
  end

  def ended_label_xs_tag
    content_tag :span, 'Ended' ,class: 'label label-warning'
  end

  def no_elements(elements_name)
    content_tag :h2, "No #{elements_name} associated with this process instance."
  end

  def elements_count(elements)
    content_tag :span, elements.to_a.count, class: 'badge'
  end

  def custom_badge(text)
    content_tag :span, text, class: 'badge'
  end

  def history_processes_table_tag(process_instances)
    content_tag :table, class: 'table table-striped table-bordered' do
      concat history_processes_header
      process_instances.each do |process_instance|
        concat history_processes_line process_instance
      end
    end
  end

  def history_processes_header
    content_tag :thead do
      concat content_tag :th, 'Id'
      concat content_tag :th, 'Business key'
      concat content_tag :th, 'Process definition Id'
      concat content_tag :th, 'Start time'
      concat content_tag :th, 'End time'
    end
  end

  def history_processes_line(process_instance)
    content_tag :tr do
      concat content_tag :td, history_process_link(process_instance)
      concat content_tag :td, process_instance.businessKey.to_s
      concat content_tag :td, process_instance.processDefinitionId.to_s
      concat content_tag :td, process_instance.startTime.to_s
      concat content_tag :td, process_instance.endTime.to_s
    end
  end

  def history_process_link(process_instance)
    link = link_to process_instance.id, process_instance_path(id: process_instance.id), data: { no_turbolink: true }
    process_instance.endTime ? link.concat(ended_label_xs_tag) : link
  end
end
