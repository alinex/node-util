Package: alinex-util
=================================================

[![Build Status](https://travis-ci.org/alinex/node-util.svg?branch=master)](https://travis-ci.org/alinex/node-util)
[![Coverage Status](https://coveralls.io/repos/alinex/node-util/badge.svg?branch=master)](https://coveralls.io/r/alinex/node-util?branch=master)
[![Dependency Status](https://gemnasium.com/alinex/node-util.png)](https://gemnasium.com/alinex/node-util)

This module will be used as incubator for different small helper methods which
are generally used for different general class types:

- general helper
- string helper
- number helper
- array helper
- object helper

> It is one of the modules of the [Alinex Universe](http://alinex.github.io/code.html)
> following the code standards defined in the [General Docs](http://alinex.github.io/develop).


Install
-------------------------------------------------

[![NPM](https://nodei.co/npm/alinex-util.png?downloads=true&downloadRank=true&stars=true)
 ![Downloads](https://nodei.co/npm-dl/alinex-util.png?months=9&height=3)
](https://www.npmjs.com/package/alinex-util)

The easiest way is to let npm add the module directly to your modules
(from within you node modules directory):

``` sh
npm install alinex-util --save
```

And update it to the latest version later:

``` sh
npm update alinex-util --save
```

Always have a look at the latest [changes](Changelog.md).


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
array = require 'alinex-util/lib/array'
```

The first line loaded all but uses only some methods, while the second line
only loads the needed type library.

The library may be used as replacement for the node util package because it also
exports the 'inspect()' method which is the only needed method from this core
package.

See the description below for each of the contained methods.


All types
-------------------------------------------------
The methods which are usable for all types are directly accessible in the main
module. All others are used through a collection named after their type.

### inspect

The [inspect](https://nodejs.org/api/util.html#util_util_inspect_object_options)
method is from the node js util package directly inherited. Use it like described
there.

__Arguments:__

* `object` to be cloned
* `options` (optional) object with:
  - `showHidden` - if true then the object's non-enumerable and symbol properties
    will be shown too. Defaults to false.
  - `depth` - tells inspect how many times to recurse while formatting the object.
    This is useful for inspecting large complicated objects. Defaults to 2. To make
    it recurse indefinitely pass null.
  - `colors` - if true, then the output will be styled with ANSI color codes.
    Defaults to false. Colors are customizable, see Customizing util.inspect colors.
  - `customInspect` - if false, then custom inspect(depth, opts) functions defined
    on the objects being inspected won't be called. Defaults to true.

### clone

This method will create a clone of the given object.
As possible all methods will be cloned, but if object instances are used they
will be referenced.

__Arguments:__

* `object`
  to be cloned
* `depth`
  (optional) maximum level of cloning deper levels will be referenced

__Returns:__

* `object`
  clone of the given object.

__Example:__

``` coffee
util = require 'alinex-util'
test = { eins: 1 }
result = util.clone test
```

This results to:

``` coffee
result = { eins: 1 }
```

### extend

Extend an object with another one.

This method will extend a given object with the entries from additional
objects. Therefore it will do a deep extend.

__Arguments:__

* `mode` (optional) string 'MODE ...' defining how the extend should work
* `object` (if not called as Object method)
  base object to be extended
* `extender`...
  multiple extenders may be given with will be cloned into the object.

__Returns:__

* `object`
  the given and maybe changed object.

__Modes:__

Multiple modes can be used with space as separator:

* `CLONE` - clone object and all extenders before extending, keeps the resulting
  objects untouched (works only globally)
* `OVERWRITE` - allow overwrite of array and object mode in specific elements
* `ARRAY_CONCAT` - (default) if no other array-mode set, will concat additional
  elements
* `ARRAY_REPLACE` - for all arrays, replace the previouse array completely instead
  of extending them
* `ARRAY_OVERWRITE` - overwrite the same index instead of extending the array
* `OBJECT_EXTEND` - (default) if no other object-mode given, will add/replace
  properties with the new ones
* `OBJECT_REPLACE` - will always replace the object completely with the new one,
  if the keys are different

This mode may also be changed on any specific element by giving a different mode
just for this operation in the extending element itself. Therefore it has to be
enabled with 'MODE OVERWRITE' gölobally and then an array
should has the mode as first element or an object as an attribute.

__Example:__

``` coffee
util = require 'alinex-util'
test = { eins: 1 }
util.extend test, { zwei: 2 }, { eins: 'eins' }, { drei: 3 }
```

This results to:

``` coffee
test = { zwei: 2, eins: 'eins', drei: 3 }
```

But keep in mind that this will change the first object, to the result, too.

You may set a mode globally or in a specific level like described show:

``` coffee
test1 = {a: [1, 2, 3], b: [1, 2, 3], c: [1, 2, 3]}
test2 = {a: [4, 5, 6], c: ['a']}
ext = util.extend 'MODE ARRAY_REPLACE', test1, test2
# ext = {a: [4, 5, 6], b: [1, 2, 3], c: ['a']}
```

``` coffee
test1 = {a: [1, 2, 3], b: [1, 2, 3], c: [1, 2, 3]}
test2 = {a: ['MODE ARRAY_REPLACE', 4, 5, 6], c: ['a']}
ext = util.extend test1, test2
# ext = {a: [4, 5, 6], b: [1, 2, 3], c: [1, 2, 3, 'a']}
```

``` coffee
test1 = {t1: {a: 1, b: 2, c: 3}, t2: {d: 4, e: 5, f: 6}}
test2 = {t1: {OBJECT_REPLACE: true, a: 4, b: 5}, t2: {d: 9}}
ext = util.extend test1, test2
# ext = {t1: {a: 4, b: 5}, t2: {d: 9, e: 5, f: 6}}
```


String type
-------------------------------------------------

### starts

This is a handy method to check that a certain string starts with the given
phrase.

__Arguments:__

* `string` (if not called as String method)
  text to be checked
* `literal`
  phrase to match
* `start` (optional)
  offset character position to start looking for

__Returns:__

* `true` if `string` starts with `literal`

__Example:__

``` coffee
util = require 'alinex-util'
test = 'abcdefg'
result = util.string.starts test, 'ab'
```

This results to:

``` text
result = true
```

### ends

This is a handy method to check that a certain string ends with the given
phrase.

__Arguments:__

* `string` (if not called as String method)
  text to be checked
* `literal`
  phrase to match
* `back` (optional)
  offset character position from the end to look for

__Returns:__

* `true` if `string` ends with `literal`

__Example:__

``` coffee
util = require 'alinex-util'
test = 'abcdefg'
result = util.string.ends test, 'fg'
```

This results to:

``` coffee
result = true
```

### repeat

Repeat a given string multiple times.

__Arguments:__

* `string` (if not called as String method)
  text to be repeated
* `n`
  number of repeats

__Returns:__

* the repeated test

__Example:__

``` coffee
util = require 'alinex-util'
test = 'ab'
result = util.string.repeat test, 3
```

This results to:

``` coffee
result = 'ababab'
```

### lpad

Left pad string to specified length.

__Arguments:__

* `string`
   text to be padded
* `n`
   final length of text
* `char`
   character used for padding (defaults to ' ')

__Returns:__

* the padded text

__Example:__

``` coffee
util = require 'alinex-util'
test = '5'
result = util.string.lpad test, 3, '0'
```

This results to:

``` coffee
result = '005'
```

### rpad

Right pad string to specified length.

__Arguments:__

* `string`
   text to be padded
* `n`
   final length of text
* `char`
   character used for padding (defaults to ' ')

__Returns:__

* the padded text

__Example:__

``` coffee
util = require 'alinex-util'
test = 'abc'
result = util.string.rpad test, 5, ' '
```

This results to:

``` coffee
result = 'abc  '
```

### cpad

Center pad string to specified length. This will add the padding on both sides.

__Arguments:__

* `string`
   text to be padded
* `n`
   final length of text
* `char`
   character used for padding (defaults to ' ')

__Returns:__

* the padded text

__Example:__

``` coffee
util = require 'alinex-util'
test = 'abc'
result = util.string.cpad test, 5, ' '
```

This results to:

``` coffee
result = 'abc  '
```

### trim

Trim given characters


__Arguments:__

* `string`
   text to be trimmed
* `chars`
   list of characters to trim off (defaults to ' \n\t')

 __Returns:__

* the padded text

__Example:__

``` coffee
util = require 'alinex-util'
test = '/var/local/'
result = util.string.trim test, '/'
```

This results to:

``` coffee
result = 'var/local'
```

### ucFirst

Make first letter upper case.

__Arguments:__

* `string` (if not called as String method)
  text to be changed

__Returns:__

* the same text but with first letter in upper case

__Example:__

``` coffee
util = require 'alinex-util'
test = 'abcdefg'
result = util.string.ucfirst test
```

This results to:

``` coffee
result = 'Abcdefg'
```


### lcFirst

Make first letter lower case.

__Arguments:__

* `string` (if not called as String method)
  text to be changed

__Returns:__

* the same text but with first letter in lower case

__Example:__

``` coffee
util = require 'alinex-util'
test = 'ABCDEFG'
result = util.string.lcFirst test
```

This results to:

``` coffee
result = 'aBCDEFG'
```

### contains

Is substring contained?

__Arguments:__

* `string`
  text to be check
* `phrase`
  text to be searched for

__Returns:__

* (bool) `true` if phrase is contained in string

__Example:__

``` coffee
util = require 'alinex-util'
test = 'abcdefg'
result1 = util.string.contains test, 'bc'
result2 = util.string.contains test, 'gh'
```

This results to:

``` coffee
result1 = true
result2 = false
```

### wordwrap

Word wraps a given text as needed.

__Arguments:__

* `width`
  maximum amount of characters per line
* `break`
  string that will be added whenever it's needed to break the line
* `cutType`
  0 = words longer than "maxLength" will not be broken
  1 = words will be broken when needed
  2 = any word that trespass the limit will be broken

__Returns:__

* (string) returns the new text


### shorten

This will shorten the given text and add ellipsis if it is too long. This is done
word aware.

__Arguments:__

* `limit`
  maximum number of characters

__Returns:__

* (string) the new text


### toList

Convert text into list or list of array (recordset).

__Arguments:__

* `rowDelimiter`
  text or regular expression to divide into lines (default '\n')
* `colDelimiter`
  text or regular expression to divide into columns

__Returns:__

* (array) the new list

__Example:__

``` coffee
util = require 'alinex-util'
test = 'one,two,three\n1,2,3\n4,5,6'
list = util.string.toList test, /\n/
table = util.string.toList test, /\n/, /,/
```

This results to:

``` coffee
list = [
  'one,teo,three'
  '1,2,3'
  '4,5,6'
]
table = [
  ['one', 'two', 'three']
  ['1', '2', '3']
  ['4', '5', '6']
]
```

### toRegExp

Convert text into regular expression object if possible..

__Returns:__

* (RegExp) or the string as it was

__Example:__

``` coffee
util = require 'alinex-util'
test = '/\n/'
test = util.string.toRegExp test
list = util.string.split test
```


Number type
-------------------------------------------------

### isInteger

Check for Integer.

This method will check that the given value is an integer.

__Arguments:__

* `value`
  to be analyzed

__Returns:__

* `true` if `value` is an integer

### isNumber

Check for number.

This method will check that the given value is a number.

__Arguments:__

* `value`
  to be analyzed

__Returns:__

* `true` if `value` is a number

### parseInt

Strict parse for Integer.

This will fail on all strings which are no real integer.

__Arguments:__

* `value`
  to be analyzed

__Returns:__

* `value` as Number or `NaN`

To check if you got a number or invalid string use `isNaN()`.

### parseSeconds

Parse human readable time to seconds.

This will fail on all strings which are no real integer.

__Arguments:__

* `value`
  to be analyzed

__Returns:__

* `value` as Number of seconds or `NaN`

To check if you got a number or invalid string use `isNaN()`.

__Example:__

``` coffee
number.parseSeconds 200          # 200
number.parseSeconds '200s'       # 200
number.parseSeconds '200S'       # 200
number.parseSeconds '5m'         # 300
number.parseSeconds '1h'         # 3600
number.parseSeconds '2.5h'       # 9000
number.parseSeconds '1d'         # 86400
number.parseSeconds '2h 5m 100s' # 7600
```

### parseMSeconds

Parse human readable time to milliseconds. It will work the same as above and
you may specify `ms` as additional unit here.


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

Copyright 2014-2016 Alexander Schilling

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

>  <http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
