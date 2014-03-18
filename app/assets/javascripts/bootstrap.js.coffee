jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()

$ ->
  $(".alert").show().delay(1000).fadeOut()
