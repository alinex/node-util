# Utility functions for objects.
# =================================================

debug = require('debug')('util:object')
debugPathSearch = require('debug')('util:object:pathsearch')
debugExtend = require('debug')('util:object:extend')
debugClone = require('debug')('util:object:clone')
util = require 'util'
chalk = require 'chalk'

# Extend object
# -------------------------------------------------
# This method will extend a given object with the entries from additional
# objects. Therefore it will do a deep extend and make all elements from the
# added objects cloned.
#
# __Arguments:__
#
# * `object`
#   base object to be extended
# * `extender`...
#   multiple extenders may be given with will be cloned into the object.
#
# __Returns:__
#
# * `object`
#   the given and maybe changed object.
#
# Use the `constructor.name` for equal object check because the constructor
# object may differ to another copy of the same class if generated in the sandbox.

# extend (array concat)
# ['CLEANUP_BEFORE', 1, 2] -> for empty array
# {CLEANUP_BEFORE: true} -> for empty object
# extend (array replace)
# 'ARRAY_REPLACE' as first element

extend = exports.extend = (obj, ext...) ->
  # read mode
  if typeof ext[0] is 'string' and ext[0] in ['ARRAY_REPLACE']
    mode = ext.shift()
  # return if no extenders given
  return obj if not ext?
  # run over extenders
  obj = null unless obj
  debugExtend "-> extend #{chalk.grey util.inspect obj}"
  # use all extenders
  for src in ext
    continue unless src?
    debugExtend "   by #{chalk.grey util.inspect src}"
    obj = {} unless obj
    # empty object
    continue if src.constructor?.name is Object.name and not Object.keys(src).length
    # arrays
    if Array.isArray src
      obj = [] unless Array.isArray obj
      obj = [] if mode is 'ARRAY_REPLACE'
      if src[0]? is 'CLEANUP_BEFORE'
        obj = []
        src.shift()
      obj.push n for n in obj
      continue
    # object literal
    if typeof src is 'object'
      # check that this is a literal
      if not src.prototype
        if src.CLEANUP_BEFORE
          obj = {}
          delete src.CLEANUP_BEFORE
        obj = {} if Array.isArray obj or not typeof obj is 'object'
        for own k, v of src
          # test to assure a key like 'toString' won't map to the standard function
          base = if k in Object.keys(obj) then obj[k] else undefined
          obj[k] = extend mode, base, v
          delete obj[k] if v is null
        continue
    # all other
    obj = src
  # return resulting obj
  debugExtend "<- #{chalk.grey util.inspect obj}"
  obj


# Deep cloning object
# -------------------------------------------------
# This method will create a clone of the given object.
#
# __Arguments:__
#
# * `object`
#   to be cloned
#
# __Returns:__
#
# * `object`
#   clone of the given  object.
clone = exports.clone = (obj) ->
  # null, undefined values check
  return obj unless obj
  debugClone "-> #{chalk.grey util.inspect obj}"
  # return primitive types
  if typeof obj in ['number', 'string', 'boolean']
    debugClone chalk.grey "   is primitive"
    return obj
  # return basic types
  for type in [Number, String, Boolean, Date]
    if obj instanceof type
      debugClone chalk.grey "   is #{type}"
      return new type obj
  # regexp
  if obj instanceof RegExp
    debugClone chalk.grey "   is RegExp"
    flags = ''
    flags += 'g' if obj.global
    flags += 'i' if obj.ignoreCase
    flags += 'm' if obj.multiline
    flags += 'y' if obj.sticky
    return new RegExp obj.source, flags
  # arrays
  if Array.isArray obj
    debugClone chalk.grey "   clone array..."
    res = []
    res[i] = clone n for n, i in obj
    return res
  if typeof obj is 'object'
    # testing that this is DOM
    if obj.nodeType and typeof obj.cloneNode is 'function'
      debugClone chalk.grey "   clone DOM node..."
      return obj.cloneNode true
#    if typeof obj.clone is 'function'
#      debugClone chalk.grey "   using clone() method"
#      return obj.clone true
    if obj.constructor.name isnt Object.name
      debugClone chalk.grey "   keep object"
      return obj
    # check that this is a literal
    if not obj.prototype
      debugClone chalk.grey "   clone object"
      res = {}
      res[i] = clone v for i, v of obj
      return res
    ###
    # create new object
    if obj.constructor
      return new (obj.constructor)
    ###
    # just keep the reference
    debugClone chalk.grey "   keep other"
    return obj


# Check for empty objects
# -------------------------------------------------
# This method will check if an object is empty. This is also true for undefined
# objects.
#
# __Arguments:__
#
# * `object`
#   to be checked
#
# __Returns:__
#
# * `boolean`
#   true if object is empty
isEmpty = module.exports.isEmpty = (obj) ->
  # true for undefined objects
  return true unless obj?
  return obj.length is 0 if obj.length?
  Object.keys(obj).length is 0


# Access path in object
# -------------------------------------------------
exports.path = path = (obj, path, separator = '/') ->
  path = path.split separator if typeof path is 'string'
  debug "get path #{util.inspect path} from #{util.inspect obj}"
  ref = obj
  for k in path
    continue unless k
    ref = ref[k]
#  console.log ref
  return ref


# Find path in object
# -------------------------------------------------
pathSearch = exports.pathSearch = (obj, path, separator = '/') ->
  path = path.split separator if typeof path is 'string'
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

# Filter object
# -------------------------------------------------
# This will create a new object with all keys that pass the test implemented
# by the provided allow(value, key, object)
filter = exports.filter = (obj, allow) ->
  result = {}
  for key of obj
    if obj.hasOwnProperty(key) and allow obj[key], key, obj
      result[key] = obj[key]
  result


# Make object's keys to lowercase
# -------------------------------------------------
lcKeys = exports.lcKeys = (obj) ->
  return obj if typeof obj isnt 'object' or Array.isArray obj
  lc = {}
  for key in Object.keys obj
    lc[key.toLowerCase()] = lcKeys obj[key]
  lc


# Add object helpers to the Object class
# -------------------------------------------------
# This will allow to call the methods directly on an object.
module.exports.addToPrototype = ->
  Object.prototype.extend = (args...) ->
    args.unshift this
    extend.apply null, args
  Object.prototype.clone = -> extend null, this
  Object.prototype.isEmpty = -> isEmpty this
  Object.prototype.path = -> (args...) ->
    args.unshift this
    path.apply null, args
  Object.prototype.pathSearch = -> (args...) ->
    args.unshift this
    pathSearch.apply null, args
  Object.prototype.filter = -> (args...) ->
    args.unshift this
    filter.apply null, args
  Object.prototype.lcKeys = -> lcKeys this
