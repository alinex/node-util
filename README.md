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
