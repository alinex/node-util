# Utility functions for objects.
# =================================================

debug = require('debug')('util')
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
extend = module.exports.extend = (obj, ext...) ->
  debug "-> extend #{chalk.grey util.inspect obj}"
  # clone if no extenders given
  return extend null, obj if not ext?
  obj = null unless obj
  # use all extenders
  for src in ext
    continue unless src?
    debug "by #{chalk.grey util.inspect src}"
    # empty object
    obj = {} unless obj
    continue if src.constructor?.name is Object.name and not Object.keys(src).length
    if typeof src isnt 'object'
      # simple variables or function
      obj = src
    else if Array.isArray src
      # array
      obj = [] unless Array.isArray obj
      for val, i in src
        debug "array[#{i}]"
        obj.push extend null, val
    else if src instanceof Date
      debug "Date"
      obj = new Date src.getTime()
    else if src instanceof RegExp
      debug "RegExp"
      flags = ''
      flags += 'g' if src.global
      flags += 'i' if src.ignoreCase
      flags += 'm' if src.multiline
      flags += 'y' if src.sticky
      obj = new RegExp src.source, flags
    else if src.constructor.name != Object.name
      debug "unknown instance (referenced)"
#     exact copy/clone not working on instances
#      obj = extendInstance obj, src
      obj = src
    else
      # object structure
      for own key, val of src
        debug "object.#{key} #{chalk.grey util.inspect val}"
        # test to assure a key like 'toString' won't map to the standard function
        base = if key in Object.keys(obj) then obj[key] else undefined
        obj[key] = extend base, val
  debug "<- #{chalk.grey util.inspect obj}"
  obj

# Extend object (with concat)
# -------------------------------------------------
# This method is like extend but will concat arrays elements directly instead
# of concat the element clones. This keeps the references under the first array.
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
extendArrayConcat = module.exports.extendArrayConcat = (obj, ext...) ->
  debug "-> extend #{chalk.grey util.inspect obj}"
  # clone if no extenders given
  return extendArrayConcat null, obj if not ext?
  obj = null unless obj
  # use all extenders
  for src in ext
    continue unless src?
    debug "by #{chalk.grey util.inspect src}"
    obj = {} unless obj
    continue if src.constructor?.name is Object.name and not Object.keys(src).length
    if typeof src isnt 'object'
      # simple variables or function
      obj = src
    else if Array.isArray src
      debug "array concat"
      # array
      obj = [] unless Array.isArray obj
      obj.push.apply obj, src
    else if src instanceof Date
      debug "Date"
      obj = new Date src.getTime()
    else if src instanceof RegExp
      debug "RegExp"
      flags = ''
      flags += 'g' if src.global
      flags += 'i' if src.ignoreCase
      flags += 'm' if src.multiline
      flags += 'y' if src.sticky
      obj = new RegExp src.source, flags
    else if src.constructor.name != Object.name
      debug "unknown instance (referenced)"
#     exact copy/clone not working on instances
#      obj = extendInstance obj, src
      obj = src
    else
      # object structure
      for own key, val of src
        debug "object.#{key} #{chalk.grey util.inspect val}"
        # test to assure a key like 'toString' won't map to the standard function
        base = if key in Object.keys(obj) then obj[key] else undefined
        obj[key] = extendArrayConcat base, val
  debug "<- #{chalk.grey util.inspect obj}"
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
module.exports.clone = (obj) ->
  extend null, obj


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
isempty = module.exports.isempty = (obj) ->
  # true for undefined objects
  return true unless obj?
  return obj.length is 0 if obj.length?
  Object.keys(obj).length is 0


# Access path in object
# -------------------------------------------------
exports.path = (obj, path, separator = '/') ->
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
  debug "get path #{util.inspect path} from #{util.inspect obj}"
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
        result.push val for key,val of obj
        return result
      for key,val of obj
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
      for key,val of obj
        continue unless typeof val is 'object'
        result = pathSearch val, path[0..]
        return result if result?
      return
    # regexp matching
    when cur.match /\W/
      cur = new RegExp "^#{cur}$"
      result = []
      for key,val of obj
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


# Add object helpers to the Object class
# -------------------------------------------------
# This will allow to call the methods directly on an object.
module.exports.addToPrototype = ->
  Object.prototype.extend = (args...) ->
    args.unshift this
    extend.apply null, args
  Object.prototype.extendArrayConcat = (args...) ->
    args.unshift this
    extend.apply null, args
  Object.prototype.clone = -> extend null, this
  Object.prototype.isempty = -> isempty this
  Object.prototype.path = -> (args...) ->
    args.unshift this
    path.apply null, args
  Object.prototype.pathSearch = -> (args...) ->
    args.unshift this
    pathSearch.apply null, args

