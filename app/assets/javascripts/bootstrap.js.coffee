jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()

$ ->
  $(".alert").show().delay(1000).fadeOut()

$ ->
  $('i').tooltip()

$ ->
  $(".reset").click ->
    $('.reset').parents('simple_form').find("input[type=text], textarea").val("")
    return
