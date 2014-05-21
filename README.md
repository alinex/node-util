Package: alinex-util
=================================================

[![Build Status] (https://travis-ci.org/alinex/node-util.svg?branch=master)](https://travis-ci.org/alinex/node-util) 
[![Coverage Status] (https://coveralls.io/repos/alinex/node-util/badge.png?branch=master)](https://coveralls.io/r/alinex/node-util?branch=master)
[![Dependency Status] (https://gemnasium.com/alinex/node-util.png)](https://gemnasium.com/alinex/node-util)

Description comes here...


Install
-------------------------------------------------

The easiest way is to let npm add the module directly:

    > npm install alinex-fs --save

[![NPM](https://nodei.co/npm/alinex-util.png?downloads=true&stars=true)](https://nodei.co/npm/alinex-util/)


Usage
-------------------------------------------------

### Extend object

This method will extend a given object with the entries from additional
objects. Therefore it will do a deep extend.

__Arguments:__

* `object`
  base object to be extended
* `extender`...
  multiple extenders may be given with will be cloned into the object.

__Returns:__

* `object`
  the given and maybe changed object.

__Example:__

    var object, result, test;
    object = require('alinex-util').object;
    test = { eins: 1 };
    result = object.extend(test, { zwei: 2 }, { eins: 'eins' }, { drei: 3 });

    { eins: 'eins', zwei: 2, drei: 3 }


### Deep cloning object

This method will create a clone of the given object.

__Arguments:__

* `object`
  to be cloned

__Returns:__

* `object`
  clone of the given  object.

__Example:__

    var object, result, test;
    object = require('alinex-util').object;
    test = { eins: 1 };
    result = object.clone(test);

    { eins: 1 }


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
