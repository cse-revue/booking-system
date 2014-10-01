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

insert_into_table = (table, to_insert, sort_field) ->
  to_compare = $(to_insert.children()[sort_field]).text()

  trs = table.children().children()
  after = null
  prev = null
  before = null
  for tr in trs[1..]
    prev = $(tr)
    tds = prev.children()
    to_compare_to = $(tds[sort_field]).text()
    if to_compare_to > to_compare
      after = prev
      break
    else
      before = prev
  if before?
    before.after(to_insert)
  else if after?
    after.before(to_insert)

manager_click = ->
    element = $(this)
    href = element.attr('data-href')
    $.post href, (resp) ->
      new_row = $(resp)
      element.parent().parent().prev().after(new_row)
      element.parent().parent().remove()
      new_row.find('.make_manager').click manager_click
      new_row.find('.remove_ticketer').click remove_ticketer_click

make_ticketer_click = ->
    element = $(this)
    href = element.attr('data-href')
    $.post href, (resp) ->
      new_row = $(resp)
      element.parent().parent().remove()
      insert_into_table $('#ticketers'), new_row, 0
      new_row.find('.remove_ticketer').click remove_ticketer_click
      new_row.find('.make_manager').click manager_click

remove_ticketer_click = ->
    element = $(this)
    href = element.attr('data-href')
    $.post href, (resp) ->
      new_row = $(resp)
      element.parent().parent().remove()
      insert_into_table $('#non-ticketers'), new_row, 0
      new_row.find('.make_ticketer').click make_ticketer_click

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


  $('.make_ticketer').click make_ticketer_click

  $('.make_manager').click manager_click

  $('.remove_ticketer').click remove_ticketer_click
