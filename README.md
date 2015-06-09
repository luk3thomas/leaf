# Seaspray

[![NPM Package Stats](https://nodei.co/npm/seaspray.png)](https://www.npmjs.org/package/seaspray)

Seaspray combines getter and setter functions for object properties with the
ability to listen for changes to the object.

Seaspray extends [EventEmitter](https://nodejs.org/api/events.html).

### get

The `get` method returns a new Seaspray object that wraps the value of the key.

```javascript
data = {
  foo: {
    bar: 1
  }
};

seaspray = new Seaspray(data);

seaspray.get();                  // Seaspray(values: { foo: { bar: 1 } })
seaspray.get('foo.bar');         // Seaspray(values: 1)

// Methods are chainable
seaspray.get('foo').get('bar');  // Seaspray(values: 1)
```

### set

The `set` method sets a property for a key on an object. If they key path does
not exist Seaspray will overwrite the keypath with the value specified.

Seaspray extends EventEmitter.  On set seaspray emits an `update` event and an
`update:key` event. Use the `on` method to respond to changes.

```javascript
data = {
  foo: {
    bar: 1
  }
};

seaspray = new Seaspray(data);

seaspray.on('update',         function(){});
seaspray.on('update:foo.bar', function(){});

seaspray.set('foo.bar', 2);   // Seaspray(values: { foo: { bar: 2 } })
                              // emits `update`
                              // emits `update:foo.bar`
```

### unwrap

The `unwrap` method exposes the underlying object or value from seaspray. Pass
a key to `unwrap` and seaspray will return the value of the key within the data
object.


```javascript
data = {
  foo: {
    bar: 1
  }
};

seaspray = new Seaspray(data);

seaspray.unwrap();             // { foo: { bar: 1 } }
seaspray.unwrap('foo.bar');    // 1
```
