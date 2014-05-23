Package: alinex-util
=================================================

[![Build Status] (https://travis-ci.org/alinex/node-util.svg?branch=master)](https://travis-ci.org/alinex/node-util) 
[![Coverage Status] (https://coveralls.io/repos/alinex/node-util/badge.png?branch=master)](https://coveralls.io/r/alinex/node-util?branch=master)
[![Dependency Status] (https://gemnasium.com/alinex/node-util.png)](https://gemnasium.com/alinex/node-util)

This module will be used as incubator for different small helper methods which 
are generally used.


Install
-------------------------------------------------

The easiest way is to let npm add the module directly:

    > npm install alinex-fs --save

[![NPM](https://nodei.co/npm/alinex-util.png?downloads=true&stars=true)](https://nodei.co/npm/alinex-util/)


Usage
-------------------------------------------------

All methods in this package can be called from the resulting function collection:

    util = require('alinex-util');
    string = util.string; // shortcut to the string functions
    object = util.object; // shortcut to the object functions

An other alternative is to add the fucntions to the appropriate objects. This is
done with the `addToPrototype` methods:

    util = require('alinex-util');
    util.addToPrototype(); // will do it for all
    util.object.addToPrototype(); // or extend only the Object class

If you call the functions from an class instance (after adding to prototype),
you won't need the first parameter:

    x = { eins: 1 };
    y = x.clone(); // instead of
    y = util.object.clone(x);


Usage of string helpers
-------------------------------------------------

### Match string start

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

    var string = require('alinex-util').string;
    var test = 'abcdefg';
    var result = string.starts(test, 'ab');

This results to:

    result = true

Or the same call using prototype extension:

    require('alinex-util').string.addToPrototype();
    var test = 'abcdefg';
    var result = test.starts('ab');


### Match string end

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

    var string = require('alinex-util').string;
    var test = 'abcdefg';
    var result = string.ends(test, 'fg');

This results to:

    result = true

Or the same call using prototype extension:

    require('alinex-util').string.addToPrototype();
    var test = 'abcdefg';
    var result = test.ends('fg');


Usage of object helpers
-------------------------------------------------

### Extend object

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

    var object = require('alinex-util').object;
    var test = { eins: 1 };
    object.extend(test, { zwei: 2 }, { eins: 'eins' }, { drei: 3 });

This results to:

    test = { eins: 'eins', zwei: 2, drei: 3 }

Or the same call using prototype extension:

    require('alinex-util').object.addToPrototype();
    var test = { eins: 1 };
    test.extend({ zwei: 2 }, { eins: 'eins' }, { drei: 3 });


### Deep cloning object

This method will create a clone of the given object.

__Arguments:__

* `object` (if not called as Object method)
  to be cloned

__Returns:__

* `object`
  clone of the given  object.

__Example:__

    var object = require('alinex-util').object;
    var test = { eins: 1 };
    var result = object.clone(test);

This results to:

    result = { eins: 1 }

Or the same call using prototype extension:

    require('alinex-util').object.addToPrototype();
    var test = { eins: 1 };
    var result = test.clone();


License
-------------------------------------------------

Copyright 2014 Alexander Schilling

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

>  <http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
