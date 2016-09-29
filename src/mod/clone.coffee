###
Clone Method
=================================================
This method will create a clone of the given object.
As possible all methods will be cloned, but if object instances are used they
will be referenced.

__Example:__

``` coffee
util = require 'alinex-util'
test = { eins: 1 }
result = util.clone test
```

This results to:

``` coffee
result = { eins: 1 }
result is test = false
```
###


# Node modules
# -------------------------------------------------
debug = require('debug')('util:clone')
util = require 'util'
chalk = require 'chalk'


# External Methods
# -------------------------------------------------

###
@name clone()
@param {Object} obj the object to be cloned
@param {Integer} [depth] maximum level of cloning deper levels will be referenced
@return {Object} the cloned object
###
module.exports = (obj, depth) ->
  # internal variables
  indent = ''
  cloned = []
  # clone method
  doClone = (obj, depth) ->
    indent += '   '
    # null, undefined values check
    debug chalk.grey "#{indent[3..]}-> #{util.inspect obj}" if debug.enabled
    unless obj
      indent = indent[3..]
      debug chalk.grey "#{indent}<- is undefined" if debug.enabled
      return obj
    if depth? and depth is 0
      indent = indent[3..]
      debug chalk.grey "#{indent}<- max depth reached" if debug.enabled
      return obj
    # return primitive types
    if typeof obj in ['number', 'string', 'boolean']
      indent = indent[3..]
      debug chalk.grey "#{indent}<- is primitive" if debug.enabled
      return obj
    # return basic types
    for type in [Number, String, Boolean, Date]
      if obj instanceof type
        indent = indent[3..]
        debug chalk.grey "#{indent}<- is #{type}" if debug.enabled
        return new type obj
    # regexp
    if obj instanceof RegExp
      indent = indent[3..]
      debug chalk.grey "#{indent}<- is RegExp"
      flags = ''
      flags += 'g' if obj.global
      flags += 'i' if obj.ignoreCase
      flags += 'm' if obj.multiline
      #flags += 'y' if obj.sticky # sticky not standardized till yet
      return new RegExp obj.source, flags
    # cyclic references
    debug chalk.grey "#{indent}++", util.inspect cloned if debug.enabled
    for e in cloned
      if e[0] is obj
        debug chalk.grey "#{indent}<- already cloned object..." if debug.enabled
        return e[1]
    # arrays
    if Array.isArray obj
      res = []
      cloned.push [obj, res]
      res[i] = doClone n, depth-1 for n, i in obj
      indent = indent[3..]
      debug chalk.grey "#{indent}<- cloned array..." if debug.enabled
      return res
    # testing that this is DOM
    if obj.nodeType and typeof obj.cloneNode is 'function'
      indent = indent[3..]
      debug chalk.grey "#{indent}<- cloned DOM node..." if debug.enabled
      res = obj.cloneNode true
      cloned.push [obj, res]
      return res
    if obj.constructor.name isnt Object.name
      indent = indent[3..]
      debug chalk.grey "#{indent}<- keep class object" if debug.enabled
      return obj
    # this is a literal
    res = {}
    cloned.push [obj, res]
    res[i] = doClone v, depth-1 for i, v of obj
    indent = indent[3..]
    debug chalk.grey "#{indent}<- cloned object" if debug.enabled
    return res
  # run cloning
  doClone obj, depth

###
Debugging
--------------------------------------------------
Debugging is possible using environment setting:

```
DEBUG=util:clone    -> shows each level of cloning
```

    util:clone -> { maxCpu: '95%', maxLoad: '400%' } +0ms
    util:clone    ++ [] +0ms
    util:clone    -> '95%' +0ms
    util:clone    <- is primitive +0ms
    util:clone    -> '400%' +0ms
    util:clone    <- is primitive +0ms
    util:clone <- cloned object +0ms
    util:clone -> { nice: -20 } +0ms
    util:clone    ++ [] +0ms
    util:clone    -> -20 +0ms
    util:clone    <- is primitive +0ms
    util:clone <- cloned object +0ms
###
