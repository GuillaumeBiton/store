class Store

  data: []
  name: 'data'

  constructor: (@name = @name) ->
    @data = if localStorage[@name] then JSON.parse(localStorage[@name]) else []

  getIndexById: (id) ->
    return @data.map((item) -> item.id).indexOf(id)

  remember: () ->
    localStorage.setItem @name, JSON.stringify @data

  save: (item) ->
    item.id ?= new Date().getTime()
    index = @getIndexById(item.id)
    if index then @data.push item else @data[index] = item
    @remember()

  remove: (id) ->
    index = @getIndexById(id)
    @data.splice index, 1
    @remember()

   clear: () ->
      @data = []
      @remember()

   find: (query) ->
      return [] if typeof query isnt "object"
      hit = Object.keys(query).length
      @data.filter (item) ->
        match = 0
        for key, val of query
            match += 1 if item[key] is val
        if match is hit then true else false

    toggle: (id, property) ->
      index = @getIndexById(id)
      if @data[index][property]? then @data[index][property] = !@data[index][property]
      @remember()

export default Store
