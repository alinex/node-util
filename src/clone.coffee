# Utility functions for objects.
# =================================================

debug = require('debug')('util:clone')
util = require 'util'
chalk = require 'chalk'


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
clone = module.exports = (obj) ->
  # null, undefined values check
  return obj unless obj
  debug "-> #{chalk.grey util.inspect obj}"
  # return primitive types
  if typeof obj in ['number', 'string', 'boolean']
    debug chalk.grey "   is primitive"
    return obj
  # return basic types
  for type in [Number, String, Boolean, Date]
    if obj instanceof type
      debug chalk.grey "   is #{type}"
      return new type obj
  # regexp
  if obj instanceof RegExp
    debug chalk.grey "   is RegExp"
    flags = ''
    flags += 'g' if obj.global
    flags += 'i' if obj.ignoreCase
    flags += 'm' if obj.multiline
    flags += 'y' if obj.sticky
    return new RegExp obj.source, flags
  # arrays
  if Array.isArray obj
    debug chalk.grey "   clone array..."
    res = []
    res[i] = clone n for n, i in obj
    return res
  if typeof obj is 'object'
    # testing that this is DOM
    if obj.nodeType and typeof obj.cloneNode is 'function'
      debug chalk.grey "   clone DOM node..."
      return obj.cloneNode true
#    if typeof obj.clone is 'function'
#      debug chalk.grey "   using clone() method"
#      return obj.clone true
    if obj.constructor.name isnt Object.name
      debug chalk.grey "   keep object"
      return obj
    # check that this is a literal
    if not obj.prototype
      debug chalk.grey "   clone object"
      res = {}
      res[i] = clone v for i, v of obj
      return res
    ###
    # create new object
    if obj.constructor
      return new (obj.constructor)
    ###
    # just keep the reference
    debug chalk.grey "   keep other"
    return obj
