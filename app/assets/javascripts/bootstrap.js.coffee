jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()

$ ->
  $(".alert").show().delay(2000).fadeOut()

# Enable tooltip for icons
$ ->
  $('i').tooltip()

# Reset form fields
$ ->
  $(".reset").click ->
    $('.reset').parents('simple_form').find("input[type=text], textarea").val("")
    return

  String::trunc = String::trunc or (n) ->
    (if @length > n then @substr(0, n - 1) + "..." else this)


  # Display file names on file selection
  $("#attachment_avatar").change ->
    txt = $(this).val().split('\\').pop()
    txt = txt.trunc 45
    $('#photo_attachment_container').find('p').html txt
    return

  # Fallback placeholder for older browsers
  $("input[type=text], textarea").placeholder()

$ ->
  $.setAjaxPagination = ->
    $('.pagination-ajax-container a').click (event) ->
      event.preventDefault()
      $.ajax type: 'GET', url: $(@).attr('href'), dataType: 'script'
      false

  $.setAjaxPagination()
