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

It is one of the modules of the [Alinex Universe](http://alinex.github.io/node-alinex)
following the code standards defined there.


Install
-------------------------------------------------

The easiest way is to let npm add the module directly:

``` sh
npm install alinex-fs --save
```

[![NPM](https://nodei.co/npm/alinex-util.png?downloads=true&stars=true)](https://nodei.co/npm/alinex-util/)


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

### ucFirst

Make first letter upper case.

__Arguments:__

* `string` (if not called as String method)
  text to be changed

__Returns:__

* the same text but with first letter in upper case


### lcFirst

Make first letter lower case.

__Arguments:__

* `string` (if not called as String method)
  text to be changed

__Returns:__

* the same text but with first letter in lower case


### contains

Is substring contained?

__Arguments:__

* `string`
  text to be check
* `phrase`
  text to be searched for

__Returns:__

* (bool) `true` if phrase is contained in string


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


### isempty

Check if object is empty or uninitialized.

__Arguments:__

* `object`
  to be checked

__Returns:__

* `boolean`
  true if object is empty


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


License
-------------------------------------------------

Copyright 2014-2015 Alexander Schilling

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

>  <http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
