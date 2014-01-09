# ** Stock prototyping **

Array.prototype.remove = (args...) ->
    output = []
    for arg in args
        index = @indexOf arg
        output.push @splice(index, 1) if index isnt -1
    output = output[0] if args.length is 1
    output

# ** Application **

# * Class Definitions *
class Module
    constructor: (title) ->
        @title = title
        @subjects = []

class Subject
    constructor: (title) ->
        @title = title

class Period
    constructor: (title, unique, obj_map) ->
        @title = title
        @unique = unique
        if obj_map?
            @obj_map = obj_map
        else
            @obj_map = false
        
class Timetable
    # structure is: [week*unlimited] = [period*8]
    constructor: () ->
        @timetable = []
        @modules = []
        @periods = []

    create_week: ->
        days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
        week = {}
        for i in days
            week[i] = (false for i in [0..8])
        @timetable.push(week)
        return @timetable.length

    add_module: (module)->
        # Check if module does not already exists
        if not module in @modules
            for i in module.subjects
                # Subjects in modules are always unique periods
                p = new Period(i.title, true, [p, module])
                @periods.push(p)
        else
            throw new Error("Module already exists")

    remove_module: (module) ->
        if module in @modules
            for i in @periods
                if i.obj_map
                    # Retrieve the Module object from the period.
                    omap = i.obj_map
                    # Test if the object mapping matches the stucture we expect
                    if omap instanceof Array and omap.length == 2
                        if omap[1] instanceof Module
                            # Check if the module in the object mapping matches
                            # the module we wish to remove
                            if omap[1] == module
                                @periods.remove(i)
        else
            throw new Error("Module does not exist")

    add_period: (title, unique) ->
        for i in @periods
            if i.title == title
                throw new Error("Period already exists")
        # 'Free' periods do not have object mapping
        p = new Period(title, unique)
        return p

    remove_period: (title) ->
        for i in @periods
            if i.title == title
                # Only remove period if it doesnt have an object map
                if not i.obj_map?
                    @periods.remove(i)
                else
                    throw new Error("Cannot remove period mapped to subject in module")

    set_period: (week, day, period, period_fill) ->
        tt_week = @timetable[week]
        tt_week[day][period] = period_fill

# * Utilty Methods Definitions *
# Populate the week
populatecal_week = (week_no, timetable) ->
    con_write("Week " + week_no, true)
    week = timetable.timetable[week_no]
    for day of week
        con_write(day, true)
        for period in week[day]
            con_write(period + " ")
        con_write("", true)

con_write = (data, newline) ->
    if newline?
        trailing = "\n"
    else
        trailing = ""
    process.stdout.write(String(data) + trailing)
    
# Main entry point
main = () ->
    # Initialise a new timetable for display with one default week
    tt = new Timetable()
    tt.create_week()

    # Populate the webpage
    populatecal_week(0, tt)
    
main()

