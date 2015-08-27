module ProcessInstancesHelper
  def variable_tag(process_instance, variable)
    is_history = !!process_instance.endTime

    if variable.type == 'serializable'
      return is_history ? history_variable_data_tag(process_instance.id, variable.name) : variable_data_tag(process_instance.id, variable.name)
    end
    return variable.value.to_s if is_history
    variable_edit_tag(process_instance.id, variable.name, variable.value)
  end

  def variable_data_tag(proc_inst_id, name)
    link_to 'Get binary data', data_process_variable_path(id: proc_inst_id, name: name)
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
end
