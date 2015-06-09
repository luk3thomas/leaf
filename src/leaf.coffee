Wheeljack      = require 'wheeljack'
{EventEmitter} = require 'events'

class Leaf extends EventEmitter

  constructor: (object, parent) ->
    @values = new Wheeljack(object)
    @parent = parent
    @

  select: (key) ->
    new Leaf(@values.get(key), @)

  unwrap: (key) ->
    if (key)
      @select(key).unwrap()
    else
      @values.object

  get: (key) ->
    @select(key)

  set: (key, newValue) ->
    oldValue = @select(key).unwrap()

    @values.set(key, newValue)
    @notify(key, oldValue, newValue)
    @

  notify: (key, oldValue, newValue) ->
    @emit('update:' + key, oldValue, newValue)

    if (@parent)
      @parent.notify(key, oldValue, newValue)
    else
      @emit('update')

  isObject: (object) ->
    typeof object is 'object' && object.pop isnt [].pop

module.exports = Leaf
