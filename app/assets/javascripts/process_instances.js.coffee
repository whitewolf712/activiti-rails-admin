$(document).on 'page:change page:load', ->
  $(".collapse").on 'hide.bs.collapse', ->
    $(@).parent().find("span.notification-header").addClass("collapsed")
  $(".collapse").on 'show.bs.collapse', ->
    $(@).parent().find("span.notification-header").removeClass("collapsed")

  $('#variables_filter').keyup ->
    rex = new RegExp($(@).val(), 'i')
    $('.variables_searchable tr.searchable_data').hide()
    $(".variables_searchable tr.searchable_data").filter(->
      rex.test $(@).text()
    ).show()

  $.fn.editable.defaults.mode = 'inline'
  $(".editable").editable type: 'text'
  $(".variable-editable").editable ajaxOptions:
    type: "put"


  $("a.fancybox").on 'click', ->
    $.fancybox
      href: @.dataset.url
      type: 'ajax'
      margin: [70, 60, 20, 60]
      scrolling: 'auto'
      autoResize: true

  $("a.upload_binary_data_link").on 'click', ->
    $(@).parent().find('input[type=file]').click()

  url = document.location.toString()
  if url.match('#')
    panelBody = $('#collapse_' + url.split('#')[1])
    panelBody.addClass 'in'
    panelBody.parent().find("span.notification-header").removeClass("collapsed")
  return