jasmine.getEnv().defaultTimeoutInterval = 100

describe 'leaf', ->

  beforeEach ->
    @Leaf = require 'leaf'
    @leaf = new @Leaf
      foo: 1
      bar:
        baz:
          qux: 2


  describe '#unwrap', ->

    it 'unwraps a value', ->
      expect(@leaf.unwrap('foo')).toBe(1)
      expect(@leaf.unwrap('bar.baz.qux')).toBe(2)


  describe '#set', ->

    it 'sets a value on an object', ->
      @leaf.set('bar.baz.qux', 5)
      expect(@leaf.unwrap('bar.baz.qux')).toBe(5)


  it 'isObject', ->
    expect(@leaf.isObject({})).        toBe true,   "object"
    expect(@leaf.isObject([])).        toBe false,  "array"
    expect(@leaf.isObject(1)).         toBe false,  "number"
    expect(@leaf.isObject(undefined)). toBe false,  "undefined"
    expect(@leaf.isObject(true)).      toBe false,  "boolean"
    expect(@leaf.isObject(Infinity)).  toBe false,  "Infinity"
    expect(@leaf.isObject(NaN)).       toBe false,  "NaN"


  describe '#notify', ->

    it "notifies update on the parent", (done) ->
      @leaf.on 'update', -> done()
      @leaf.set('foo', 2)

    it "notifies update:key on the parent", (done) ->
      @leaf.on 'update:foo', -> done()
      @leaf.set('foo', 2)

    it "notifies update on the child", (done) ->
      @leaf.on 'update', -> done()
      @leaf.select('bar').select('baz').set('qux', 3)

    it "notifies update:key on the child", (done) ->
      @leaf.on 'update:qux', (a, b) ->
        expect(a).toBe 2, 'old value'
        expect(b).toBe 3, 'new value'
        done()
      @leaf.select('bar').select('baz').set('qux', 3)

    it "notifies update:key on the child", (done) ->
      child = @leaf.select('bar.baz')
      child.on 'update:qux', (a, b) ->
        expect(a).toBe 2, 'old value'
        expect(b).toBe 3, 'new value'
        done()
      child.set('qux', 3)
