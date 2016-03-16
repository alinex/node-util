Package: alinex-util
=================================================

[![Build Status](https://travis-ci.org/alinex/node-util.svg?branch=master)](https://travis-ci.org/alinex/node-util)
[![Coverage Status](https://coveralls.io/repos/alinex/node-util/badge.svg?branch=master)](https://coveralls.io/r/alinex/node-util?branch=master)
[![Dependency Status](https://gemnasium.com/alinex/node-util.png)](https://gemnasium.com/alinex/node-util)

This module will be used as incubator for different small helper methods which
are generally used for different general class types:

- string helper
- number helper
- array helper
- object helper
- may extend the base classes

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

All methods in this package can be called from the resulting function collection:

``` coffee
util = require 'alinex-util'
string = util.string # shortcut to the string functions
object = util.object # shortcut to the object functions
```

Or shorter:

``` coffee
{string,object} = require 'alinex-util'
array = require 'alinex-util/lib/array'
```
Or directly import the needed objects with:

``` coffee
util = require 'alinex-util'
util.addToPrototype() # will do it for all
util.object.addToPrototype() # or extend only the Object class
```
Or you may inlcude only the needed types separately:

``` coffee
x = { eins: 1 }
y = x.clone() # instead of
y = util.object.clone x
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
string = require('alinex-util').string
test = 'abcdefg'
result = string.starts test, 'ab'
```

This results to:

``` coffee
result = true
```

Or the same call using prototype extension:

``` coffee
require('alinex-util').string.addToPrototype()
test = 'abcdefg'
result = test.starts 'ab'
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
string = require('alinex-util').string
test = 'abcdefg'
result = string.ends test, 'fg'
```

This results to:

``` coffee
result = true
```

Or the same call using prototype extension:

``` coffee
require('alinex-util').string.addToPrototype()
test = 'abcdefg'
result = test.ends 'fg'
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
string = require('alinex-util').string
test = 'ab'
result = string.repeat test, 3
```

This results to:

``` coffee
result = 'ababab'
```

Or the same call using prototype extension:

``` coffee
require('alinex-util').string.addToPrototype()
test = 'ab'
result = test.repeat 3
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
string = require('alinex-util').string
test = '5'
result = string.lpad test, 3, '0'
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
string = require('alinex-util').string
test = 'abc'
result = string.rpad test, 5, ' '
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
string = require('alinex-util').string
test = 'abc'
result = string.cpad test, 5, ' '
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
string = require('alinex-util').string
test = '/var/local/'
result = string.trim test, '/'
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
string = require('alinex-util').string
test = 'abcdefg'
result = string.ucfirst test
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
string = require('alinex-util').string
test = 'ABCDEFG'
result = string.lcFirst test
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
string = require('alinex-util').string
test = 'abcdefg'
result1 = string.contains test, 'bc'
result2 = string.contains test, 'gh'
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

### extend

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
object = require('alinex-util').object
test = { eins: 1 }
object.extend test, { zwei: 2 }, { eins: 'eins' }, { drei: 3 }
```

This results to:

``` coffee
test = { eins: 'eins', zwei: 2, drei: 3 }
```

Or the same call using prototype extension:

``` coffee
require('alinex-util').object.addToPrototype()
test = { eins: 1 }
test.extend { zwei: 2 }, { eins: 'eins' }, { drei: 3 }
```

To remove a key from the structure by overloading set it's value to null.

### extendArrayConcat

This method is like extend but will concat arrays elements directly instead
of concat the element clones. This keeps the references under the first array.


### clone

Deep cloning of an object.

This method will create a clone of the given object.

__Arguments:__

* `object` (if not called as Object method)
  to be cloned

__Returns:__

* `object`
  clone of the given  object.

__Example:__

``` coffee
object = require('alinex-util').object
test = { eins: 1 }
result = object.clone test
```

This results to:

``` coffee
result = { eins: 1 }
```

Or the same call using prototype extension:

``` coffee
require('alinex-util').object.addToPrototype()
test = { eins: 1 }
result = test.clone()
```


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
object = require('alinex-util').object
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
result = object.path test, '/object/numbers'
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
object = require('alinex-util').object
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
result = object.pathSearch test, '**/one'
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
object = require('alinex-util').object
test =
  one: 1
  two: 2
  three: 3
  four: 4
result = object.filter test, (value) -> value < 3
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
object = require('alinex-util').object
test =
  One: 1
  TWO:
    three: 3
    fouR: 4
result = object.lcKeys test
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
array = require('alinex-util').array
test = [ 1,2,3,4,5 ]
result = array.last test
```

This results to:

``` coffee
result = 5
```

Or the same call using prototype extension:

``` coffee
require('alinex-util').array.addToPrototype()
test = [ 1,2,3,4,5 ]
result = test.last()
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
array = require('alinex-util').array
test = [ 1,2,2,3,4,1,5 ]
result = array.unique test
```

This results to:

``` coffee
result = [1,2,3,4,5]
```

Or the same call using prototype extension:

``` coffee
require('alinex-util').array.addToPrototype()
test = [ 1,2,2,3,4,1,5 ]
result = test.unique
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
array = require('alinex-util').array
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
result = array.sortBy test, 'last', '-first'
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
