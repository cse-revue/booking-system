to_web_name = (str) -> str.toLowerCase().replace /\s/g, '_'

webname_changed = false

searchable_table = (input, table, fields) ->
  c = table[0].id + '-match'
  c1 = table[0].id + '-orignal'
  input.keyup ->
    $(".#{c}").remove()
    $(".#{c1}").show()
    query = input.val().toLowerCase()
    table.children().children().each ->
      row = $(this)
      # for each table row
      cells = row.children()
      for i in fields
        cell = $(cells[i])
        if cell[0].tagName.toLowerCase() == "th"
          return
        original = cell.text()
        f = original.toLowerCase()
        m = f.match query
        if m
          matching = original.substring(m.index, m.index+m[0].length)
          hi = $("<span class='#{c}'><span>#{original.substring(0, m.index)}</span><span style='background-color:yellow'>#{matching}</span><span>#{original.substring(m.index+m[0].length)}</span></span>")

          cell.html("<span class='#{c1}' style='display:none'>#{original}</span>")
          row.show()
          cell.append(hi)
          break
        else
          row.hide()




$ ->
  $('#production_title').keyup ->
    if not webname_changed
      setTimeout ->
        $('#production_webname').val(to_web_name($('#production_title').val()))
      , 1
  $('#production_webname').keydown ->
      webname_changed = true


  searchable_table $('#search-ticketers'), $('#ticketers'), [0, 1]
  searchable_table $('#search-non-ticketers'), $('#non-ticketers'), [0, 1]
