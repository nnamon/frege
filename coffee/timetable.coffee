class Module
    constructor: (title) ->
        @title = title
        @subjects = []

class Subject
    constructor: (title) ->
        @title = title

class Timetable
    # structure is: [week*unlimited] = [period*8]
    constructor: () ->
        @timetable = []

    create_week: ->
        week = ((false for i in [0..8]) for i in [0..7])
        @timetable.push(week)
        return @timetable.length

    set_period: (week, day, period, period_fill) ->
        tt_week = @timetable[week]
        tt_week[day][period] = period_fill

# Populate the week
populatecal_week = (week_no, timetable) ->
    for day in timetable.timetable[week_no]
        for period in day
            console.log(period)
        
# Main entry point
main = () ->
    tt = new Timetable()
    tt.create_week()
    tt.set_period(0, 0, 0, "Safety")
    populatecal_week(0, tt)
    console.log(tt)
    
main()

