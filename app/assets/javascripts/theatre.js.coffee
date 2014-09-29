seats = []

class Seat
    @statuses = ['free', 'booked', 'unavailable']
    @status_class: (status) -> "#{status}-seat"

    constructor: (@div) ->
        $(@div).data('seat', this)
        @status = "free"

    clear_status: ->
        Seat.statuses.map (s) => $(@div).removeClass Seat.status_class s

    set_status: (@status) ->
        this.clear_status()
        $(@div).addClass Seat.status_class @status
    
    toggle_free_status: (@non_free = "booked") ->
        if @status == "free"
            this.set_status @non_free
        else
            this.set_status "free"

$ ->
    console.debug(Seat.a)
    $('.seat').each -> seats.push new Seat this

    $('.seat').click (event) ->
        $(this).data('seat').toggle_free_status()
