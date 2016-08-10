Alinex Util: Readme
=================================================

[![Build Status](https://travis-ci.org/alinex/node-util.svg?branch=master)](https://travis-ci.org/alinex/node-util)
[![Coverage Status](https://coveralls.io/repos/alinex/node-util/badge.svg?branch=master)](https://coveralls.io/r/alinex/node-util?branch=master)
[![Dependency Status](https://gemnasium.com/alinex/node-util.png)](https://gemnasium.com/alinex/node-util)
[![GitHub](https://assets-cdn.github.com/favicon.ico)](https://github.com/alinex/node-util "Code on GitHub")
<!-- {.right} -->

This module will be used as incubator for different small helper methods which
are generally used for different general class types:

- general helper
- string helper
- number helper
- array helper
- object helper

> It is one of the modules of the [Alinex Namespace](http://alinex.github.io/code.html)
> following the code standards defined in the [General Docs](http://alinex.github.io/develop).

__Read the complete documentation under
[https://alinex.github.io/node-util](https://alinex.github.io/node-util).__
<!-- {p: .hide} -->


Install
-------------------------------------------------

[![NPM](https://nodei.co/npm/alinex-util.png?downloads=true&downloadRank=true&stars=true)
 ![Downloads](https://nodei.co/npm-dl/alinex-util.png?months=9&height=3)
](https://www.npmjs.com/package/alinex-util)

> See the {@link Changelog.md} for a list of changes in recent versions.

The easiest way is to let npm add the module directly to your modules
(from within you node modules directory):

``` sh
npm install alinex-util --save
```


General Usage
-------------------------------------------------

All methods in this package can be called from the util object:

``` coffee
util = require 'alinex-util'
raw = { eins: 1 }
copy = util.clone raw
console.log util.inspect copy
```

Or you may directly import only the needed objects with:

``` coffee
{string, object} = require 'alinex-util'
array = require 'alinex-util/lib/mod/array'
```

The first example load all methods, while the second example
only load the needed type library.

The library may be used as replacement for the node util package because it also
exports the {@link util.inspect} method from NodeJS core which is the only really
needed method from this package.









Object
-------------------------------------------------

### isCyclic

This will check an object if it contains circular references.

__Arguments:__

* `object` (if not called as Object method)
  base object to be checked

__Returns:__

* `boolean`
  true if the object contains circular references

__Example:__

``` coffee
util = require 'alinex-util'
test = { eins: 1 }
util.object.isCyclic test # will be false
test.zwei = test.eins
util.object.isCyclic test # will be true
```

### getCyclic

Detects circular references but instead of only checking it list all cyclic objects.

__Arguments:__

* `object` (if not called as Object method)
  base object to be checked

__Returns:__

* `array`
  list of objects which are circular

__Example:__

``` coffee
util = require 'alinex-util'
test = { eins: 1 }
util.object.getCyclic test # empty list []
test.zwei = test.eins
util.object.getCyclic test # [{ eins: 1 }]
```

### extend (deprecated)

Extend an object with another one.

This method will extend a given object with the entries from additional
objects. Therefore it will do a deep extend.

__Arguments:__

* `object` (if not called as Object method)
  base object to be extended
* `extender`...
  multiple extenders may be given with will be cloned into the object.

__Returns:__

* `object`
  the given and maybe changed object.

__Example:__

``` coffee
util = require 'alinex-util'
test = { eins: 1 }
util.extend test, { zwei: 2 }, { eins: 'eins' }, { drei: 3 }
```

This results to:

``` coffee
test = { eins: 'eins', zwei: 2, drei: 3 }
```

To remove a key from the structure by overloading set it's value to null.

### extendArrayConcat (deprecated)

This method is like extend but will concat arrays elements directly instead
of concat the element clones. This keeps the references under the first array.

### extendArrayReplace (deprecated)

This method is like extend but will replace arrays elements directly instead
of concat the element clones.

### clone (deprecated)

Deep cloning of an object.

This method will create a clone of the given object.

__Arguments:__

* `object` (if not called as Object method)
  to be cloned

__Returns:__

* `object`
  clone of the given  object.

### isEmpty

Check if object is empty or uninitialized.

__Arguments:__

* `object`
  to be checked

__Returns:__

* `boolean`
  true if object is empty


### path

This method allows you to access an element deep in an object's structure by
giving only the path to the element.

__Arguments:__

* `object`
  to be searched
* `path`
  (string or Array) specifying which element to reference
* `separator`
  (string or RegExp) used as separator, defaults to `/`

__Returns:__

* element at the position of the path or `undefined` if not found

__Example:__

``` coffee
util = require 'alinex-util'
test =
  string: 'test'
  object:
    numbers:
      one: 1
      two: 2
  list: [
    one: 11
  ,
    two: 12
  ]
result = util.object.path test, '/object/numbers'
```

This results to:

``` coffee
result = { one: 1, two: 2 }
```

### pathSearch

Like path but here you may give a search pattern to find the element. It may
also find multiple elements which will be returned in a list.

__Arguments:__

* `object`
  to be searched
* `path`
  (string or Array) specifying which element to reference
* `separator`
  (string or RegExp) used as separator, defaults to `/`

__Returns:__

* element at the position of the path or `undefined` if not found

__Example:__

``` coffee
util = require 'alinex-util'
test =
  string: 'test'
  object:
    numbers:
      one: 1
      two: 2
  list: [
    one: 11
  ,
    two: 12
  ]
result = util.object.pathSearch test, '**/one'
```

This results to:

``` coffee
result = 1
```

__Pattern__

You may specify like in the following examples (using the default separator).

``` text
name - get first element with this name
group/sub/name - get element with path
```

You can search by using asterisk as directory placeholder or a double asterisk to
go multiple level depth:

``` text
name/*/min - within any subelement
name/*/*/min - within any subelement (two level depth)
name/**/min - within any subelement in any depth
```

You may also use regexp notation to find the correct element:

``` text
name/test[AB]/min - pattern match with one missing character
name/test\d+/min - pattern match with multiple missing characters
```

See the [Mozilla Developer Network](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/RegExp)
for the possible syntax but without modifier.


### filter

Like the [filter](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Array/filter)
method of arrays you may filter object entries here.

__Arguments:__

* `object`
  to be filtered
* `allow`
  (function) to be called like `allow(value, key, object)` and if it returns true
  the entry will be copied to the resulting object

__Returns:__

* data object with all or some entries from the original

__Example:__

``` coffee
util = require 'alinex-util'
test =
  one: 1
  two: 2
  three: 3
  four: 4
result = util.object.filter test, (value) -> value < 3
```

This results to:

``` coffee
result =
  one: 1
  two: 2
```


### lcKeys

Make the keys within a deep object all lowercase.

__Arguments:__

* `object`
  to be optimized

__Returns:__

* data object with all keys in lowercase

__Example:__

``` coffee
util = require 'alinex-util'
test =
  One: 1
  TWO:
    three: 3
    fouR: 4
result = util.object.lcKeys test
```

Will result in:

``` coffee
result =
  one: 1
  two:
    three: 3
    four: 4
```

Array object
-------------------------------------------------

### last

Get the last element.

__Arguments:__

* `array`
  of elements to work on
* `back` (optional)
  offset character position from the end to look for

__Returns:__

* last element value

__Example:__

``` coffee
util = require 'alinex-util'
test = [ 1,2,3,4,5 ]
result = util.array.last test
```

This results to:

``` coffee
result = 5
```

### unique

Remove duplicate entries from array.

__Arguments:__

* `array`
  of elements to work on

__Returns:__

* new array with duplicates removed

__Example:__

``` coffee
util = require 'alinex-util'
test = [ 1,2,2,3,4,1,5 ]
result = util.array.unique test
```

This results to:

``` coffee
result = [1,2,3,4,5]
```

### sortBy

Sort array of objects.

__Arguments:__

* `array`
  of objects to work on

__Returns:__

* new array in sorted order

__Example:__

``` coffee
util = require 'alinex-util'
test = [
  {first: 'Johann Sebastion', last: 'Bach'}
  {first: 'Wolfgang Amadeus', last: 'Mozart'}
  {first: 'Joseph', last: 'Haydn'}
  {first: 'Richard', last: 'Wagner'}
  {first: 'Antonio', last: 'Vivaldi'}
  {first: 'Michael', last: 'Haydn'}
  {first: 'Franz', last: 'Schubert'}
]
# sort by last name ascending and first name descending
result = util.array.sortBy test, 'last', '-first'
```

This results to:

``` coffee
result = [
  {first: 'Johann Sebastion', last: 'Bach'}
  {first: 'Michael', last: 'Haydn'}
  {first: 'Joseph', last: 'Haydn'}
  {first: 'Wolfgang Amadeus', last: 'Mozart'}
  {first: 'Franz', last: 'Schubert'}
  {first: 'Antonio', last: 'Vivaldi'}
  {first: 'Richard', last: 'Wagner'}  
]
```

Like displayed above you may give one or multiple field names to sort by the
earlier has precedence. If field name starts with '-' sign it will sort in
descending order.



Function Wrapper
-------------------------------------------------

The following functions are used to wrap functions to give them more functionality.
You will get a resulting function which can be called any time.

In all of the following methods you may give an optional context to use as first
parameter. So to call it from class do so like:

``` coffee
class = Test
  init: util.function.once this, (cb) ->
    # method...
    cb null, @status
```

That allows your function to access class members and methods. Keep in mind to use
`=>` if you use sub functions.

If you use it in `module.exports` then do it as follows:

``` coffee
module.exports =
  anyMethod: (cb) ->
  # and so on

module.exports.init = util.function.once module.exports, (cb) ->
  # method...
  @anyMethod cb
```

Like you see above you have to declare this method separately so that the `util.function.once`
method can access the now already defined module.exports object.

### once

The second and later calls will return with the same result:

``` coffee
fn = util.function.once (cb) ->
  time = process.hrtime()
  setTimeout ->
    cb null, time[1]
  , 1000
```

Use this to make some initializations which only have to run once but neither
function may start because it is not done:

``` coffee
async.parallel [ fn, fn ], (err, results) ->
  # same as with `once.atime` it will come here exactly after the
  # first call finished because the second one will get the
  # result the same time
  # results here will be the same integer, twice
  fn (err, result) ->
    # and this call will return imediately with the previous result
```

### onceSkip

A function may be wrapped with the once method:

``` coffee
fn = util.function.onceSkip (a, b, cb) -> cb null, a + b
```

And now you can call the function as normal but on the second call it will
return imediately without running the code:

``` coffee
fn 2, 3, (err, x) ->
  // x will now be 5
  fn 2, 9, (err, x) ->
    // err will now be set on the second call
```

You may use this helper in case of initialization (wait) there a specific
method have to run once before any other call can succeed. Or then events
are involved and an error event will trigger the callback and the end event will
do the same.

### onceThrow

Throw an error if it is called a second time:

``` coffee
fn = util.function.onceThrow (a, b, cb) -> cb null, a + b
```

If you call this method multiple times it will throw an exception:

``` coffee
fn 2, 3, (err, x) ->
  # x will now be 5
  fn 2, 9, (err, x) ->
    # will neither get there because an exception is thrown above
```

### onceTime

Only run it once at a time, queue following requests and send them the result
of the next run. All calls get the same result, but then the process is already
started it will list the following calls for the next round. This assures that
their result is from the newest data set because you may changed something
while the first run was already working.

``` coffee
fn = util.function.onceTime (cb) ->
  time = process.hrtime()
  setTimeout ->
    cb null, time[1]
  , 1000
```

And now you may call it multiple times but it will not run more than once
simultaneously. But all simultaneous calls will get the same result.

``` coffee
async.parallel [ fn, fn ], (err, results) ->
  # will come here exactly after the first call finished (because the
  # second will do so the same time)
  # results here will be the same integer, twice
```


License
-------------------------------------------------

(C) Copyright 2014-2016 Alexander Schilling

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

>  <http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
