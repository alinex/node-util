# Utility functions for objects.
# =================================================

# Node modules
# -------------------------------------------------
debug = require('debug')('util:clone')
util = require 'util'
chalk = require 'chalk'


# Indention
# -------------------------------------------------
# Because the function works synchrone, the indent variable can be used accross
# all calls to show the level in the debug messages. It is set to 3 spaces for
# the initial call increased by 3 every subcall.
indent = ''


# Deep cloning object
# -------------------------------------------------
# This method will create a clone of the given object.
# As possible all methods will be cloned, but if object instances are used they
# will be referenced.
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
  indent += '   '
  # null, undefined values check
  debug chalk.grey "#{indent[3..]}-> #{util.inspect obj}"
  unless obj
    indent = indent[3..]
    debug chalk.grey "#{indent}<- is undefined"
    return obj
  # return primitive types
  if typeof obj in ['number', 'string', 'boolean']
    indent = indent[3..]
    debug chalk.grey "#{indent}<- is primitive"
    return obj
  # return basic types
  for type in [Number, String, Boolean, Date]
    if obj instanceof type
      indent = indent[3..]
      debug chalk.grey "#{indent}<- is #{type}"
      return new type obj
  # regexp
  if obj instanceof RegExp
    indent = indent[3..]
    debug chalk.grey "#{indent}<- is RegExp"
    flags = ''
    flags += 'g' if obj.global
    flags += 'i' if obj.ignoreCase
    flags += 'm' if obj.multiline
    ### sticky not standardized till yet
    flags += 'y' if obj.sticky
    ###
    return new RegExp obj.source, flags
  # arrays
  if Array.isArray obj
    res = []
    res[i] = clone n for n, i in obj
    indent = indent[3..]
    debug chalk.grey "#{indent}<- cloned array..."
    return res
  # typeof obj is 'object'
  # testing that this is DOM
  if obj.nodeType and typeof obj.cloneNode is 'function'
    indent = indent[3..]
    debug chalk.grey "#{indent}<- cloned DOM node..."
    return obj.cloneNode true
#    if typeof obj.clone is 'function'
#      debug chalk.grey "   using clone() method"
#      return obj.clone true
  if obj.constructor.name isnt Object.name
    indent = indent[3..]
    debug chalk.grey "#{indent}<- keep class object"
    return obj
  # this is a literal
  res = {}
  res[i] = clone v for i, v of obj
  indent = indent[3..]
  debug chalk.grey "#{indent}<- cloned object"
  return res
