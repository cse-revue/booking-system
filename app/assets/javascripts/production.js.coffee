to_web_name = (str) -> str.toLowerCase().replace /\s/g, '_'

webname_changed = false

$ ->
  $('#production_title').keyup ->
    if not webname_changed
      $('#production_webname').val(to_web_name($('#production_title').val()))
  $('#production_webname').keydown ->
      webname_changed = true
