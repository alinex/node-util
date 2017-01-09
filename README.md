Alinex Util: Readme
=================================================

[![GitHub watchers](
  https://img.shields.io/github/watchers/alinex/node-util.svg?style=social&label=Watch&maxAge=2592000)](
  https://github.com/alinex/node-util/subscription)
<!-- {.hidden-small} -->
[![GitHub stars](
  https://img.shields.io/github/stars/alinex/node-util.svg?style=social&label=Star&maxAge=2592000)](
  https://github.com/alinex/node-util)
[![GitHub forks](
  https://img.shields.io/github/forks/alinex/node-util.svg?style=social&label=Fork&maxAge=2592000)](
  https://github.com/alinex/node-util)
<!-- {.hidden-small} -->
<!-- {p:.right} -->

[![npm package](
  https://img.shields.io/npm/v/alinex-util.svg?maxAge=2592000&label=latest%20version)](
  https://www.npmjs.com/package/alinex-util)
[![latest version](
  https://img.shields.io/npm/l/alinex-util.svg?maxAge=2592000)](
  #license)
<!-- {.hidden-small} -->
[![Travis status](
  https://img.shields.io/travis/alinex/node-util.svg?maxAge=2592000&label=develop)](
  https://travis-ci.org/alinex/node-util)
[![Coveralls status](
  https://img.shields.io/coveralls/alinex/node-util.svg?maxAge=2592000)](
  https://coveralls.io/r/alinex/node-util?branch=master)
[![Gemnasium status](
  https://img.shields.io/gemnasium/alinex/node-util.svg?maxAge=2592000)](
  https://gemnasium.com/alinex/node-util)
[![GitHub issues](
  https://img.shields.io/github/issues/alinex/node-util.svg?maxAge=2592000)](
  https://github.com/alinex/node-util/issues)
<!-- {.hidden-small} -->


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
<!-- {p: .hidden} -->


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


License
-------------------------------------------------

(C) Copyright 2014-2017 Alexander Schilling

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

>  <http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
