jasmine.getEnv().defaultTimeoutInterval = 100

describe 'seaspray', ->

  beforeEach ->
    @Seaspray = require 'seaspray'
    @seaspray = new @Seaspray
      foo: 1
      bar:
        baz:
          qux: 2


  describe '#unwrap', ->

    it 'unwraps a value', ->
      expect(@seaspray.unwrap('foo')).toBe(1)
      expect(@seaspray.unwrap('bar.baz.qux')).toBe(2)


  describe '#set', ->

    it 'sets a value on an object', ->
      @seaspray.set('bar.baz.qux', 5)
      expect(@seaspray.unwrap('bar.baz.qux')).toBe(5)


  it 'isObject', ->
    expect(@seaspray.isObject({})).        toBe true,   "object"
    expect(@seaspray.isObject([])).        toBe false,  "array"
    expect(@seaspray.isObject(1)).         toBe false,  "number"
    expect(@seaspray.isObject(undefined)). toBe false,  "undefined"
    expect(@seaspray.isObject(true)).      toBe false,  "boolean"
    expect(@seaspray.isObject(Infinity)).  toBe false,  "Infinity"
    expect(@seaspray.isObject(NaN)).       toBe false,  "NaN"


  describe '#notify', ->

    it "notifies update on the parent", (done) ->
      @seaspray.on 'update', -> done()
      @seaspray.set('foo', 2)

    it "notifies update:key on the parent", (done) ->
      @seaspray.on 'update:foo', -> done()
      @seaspray.set('foo', 2)

    it "notifies update on the child", (done) ->
      @seaspray.on 'update', -> done()
      @seaspray.select('bar').select('baz').set('qux', 3)

    it "notifies update:key on the child", (done) ->
      @seaspray.on 'update:qux', (a, b) ->
        expect(a).toBe 2, 'old value'
        expect(b).toBe 3, 'new value'
        done()
      @seaspray.select('bar').select('baz').set('qux', 3)

    it "notifies update:key on the child", (done) ->
      child = @seaspray.select('bar.baz')
      child.on 'update:qux', (a, b) ->
        expect(a).toBe 2, 'old value'
        expect(b).toBe 3, 'new value'
        done()
      child.set('qux', 3)
