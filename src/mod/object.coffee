###
Object Methods
=================================================
###


# Node Modules
# -----------------------------------------------
debug = require('debug')('util:object')
debugPathSearch = require('debug')('util:object:pathsearch')
util = require 'util'


# Exported Methods
# -------------------------------------------------

###
This method will check if an object is empty. This is also true for undefined
objects.

@param {Object} object to be checked
@return {Boolean} `true` if object is empty
###
module.exports.isEmpty = (obj) ->
  # true for undefined objects
  return true unless obj?
  return obj.length is 0 if obj.length?
  Object.keys(obj).length is 0

###
This method allows you to access an element deep in an object's structure by
giving only the path to the element.

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

@param {Object} object to be searched
@param {String|Array} path specifying which element to reference
@param {String|RegExp} [separator=/] used as separator
@return element at the position of the path or `undefined` if not found
###
exports.path = (obj, path, separator = '/') ->
  path = path.split separator if typeof path is 'string'
  debug "get path #{util.inspect path} from #{util.inspect obj}" if debug.enabled
  ref = obj
  for k in path
    continue unless k
    ref = ref[k]
  return ref

#####
# Like path but here you may give a search pattern to find the element. It may
# also find multiple elements which will be returned in a list.
#
# __Example:__
#
# ``` coffee
# util = require 'alinex-util'
# test =
#   string: 'test'
#   object:
#     numbers:
#       one: 1
#       two: 2
#   list: [
#     one: 11
#   ,
#     two: 12
#   ]
# result = util.object.pathSearch test, '**/one'
# ```
#
# This results to:
#
# ``` coffee
# result = 1
# ```
#
# __Pattern__
#
# You may specify like in the following examples (using the default separator).
#
#     name - get first element with this name
#     group/sub/name - get element with path
#
# You can search by using asterisk as directory placeholder or a double asterisk to
# go multiple level depth:
#
#     name/*/min - within any subelement
#     name/*/*/min - within any subelement (two level depth)
#     name/**/min - within any subelement in any depth
#
# You may also use regexp notation to find the correct element:
#
#     name/test[AB]/min - pattern match with one missing character
#     name/test\d+/min - pattern match with multiple missing characters
#
# See {@link RegExp} for the possible syntax but without modifier.
#
# @param {Object} object to be searched
# @param {String|Array} path specifying which element to reference
# @param {String|RegExp} [separator=/] used as separator
# @return element at the position of the path or `undefined` if not found
pathSearch = exports.pathSearch = (obj, path, separator = '/') ->
  path = path.split separator if typeof path is 'string'
  if debugPathSearch.enabled
    debugPathSearch "get path #{util.inspect path} from #{util.inspect obj}"
  return obj unless path.length
  cur = path.shift()
  # step over empty paths like //
  cur = path.shift() while cur is '' and path.length
  return obj if cur is ''
  result = obj
  switch
    # wildcard path
    when cur is '*'
      return obj unless path.length
      unless path.length
        result = []
        result.push val for key, val of obj
        return result
      for key, val of obj
        continue unless typeof val is 'object'
        result = pathSearch val, path[0..]
        return result if result?
      return
    # recursive wildcard
    when cur is '**'
      return obj unless path.length
      result = pathSearch result, path[0..]
      return result if result?
      path.unshift cur
      for key, val of obj
        continue unless typeof val is 'object'
        result = pathSearch val, path[0..]
        return result if result?
      return
    # regexp matching
    when cur.match /\W/
      cur = new RegExp "^#{cur}$"
      result = []
      for key, val of obj
        result.push val if key.match cur
      return unless result.length
      result = result[0] if result.length is 1
      result
    # concrete name
    else
      result = obj?[cur]
      return unless result?
      return pathSearch result, path if path.length
      result

###
Like the {@link Array.filter()} method of arrays you may filter object entries here.

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

@param {Object} obj to be filtered
@param {Function} will be called for each entry with:
- `value` - the current value
- `key` - `String` the current key name
- `obj` - the whole object

It should return a `Boolean` value. If `true` the entry will be copied to the
resulting object.
@return {Object} data object with all or some entries from the original
###
exports.filter = (obj, allow) ->
  result = {}
  for key of obj
    if obj.hasOwnProperty(key) and allow obj[key], key, obj
      result[key] = obj[key]
  result

###
Make the keys within a deep object all lowercase.

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

@param {Object} obj to be optimized
@return {Object} data object with all keys in lowercase
###
lcKeys = exports.lcKeys = (obj) ->
  return obj if typeof obj isnt 'object' or Array.isArray obj
  lc = {}
  for key in Object.keys obj
    lc[key.toLowerCase()] = lcKeys obj[key]
  lc

###
This will check an object if it contains circular references.

__Example:__

``` coffee
util = require 'alinex-util'
test = { eins: 1 }
util.object.isCyclic test # will be false
test.zwei = test.eins
util.object.isCyclic test # will be true
```

@param {Object} obj to be checked
@return {Boolean} `true` if the object contains circular references
###
exports.isCyclic = (obj) ->
  checked = []
  detect = (obj) ->
    if obj and typeof obj is 'object'
      return true if obj in checked
      checked.push obj
      for key of obj
        if obj.hasOwnProperty(key) and detect obj[key]
          return true
    false
  detect obj

###
Detects circular references but instead of only checking it list all cyclic objects.

__Example:__

``` coffee
util = require 'alinex-util'
test = { eins: 1 }
util.object.getCyclic test # empty list []
test.zwei = test.eins
util.object.getCyclic test # [{ eins: 1 }]
```

@param {Object} obj to be checked
@return {Array} list of objects which are circular
###
exports.getCyclic = (obj) ->
  checked = []
  cyclic = []
  detect = (obj) ->
    if obj and typeof obj is 'object'
      if obj in checked and not (obj in cyclic)
        return cyclic.push obj
      checked.push obj
      for key of obj
        detect obj[key] if obj.hasOwnProperty key
  detect obj
  cyclic
