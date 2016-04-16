# Utility functions for objects.
# =================================================

debug = require('debug')('util:extend')
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
  debug "-> extend #{chalk.grey util.inspect obj}"
  # use all extenders
  for src in ext
    continue unless src?
    debug "   by #{chalk.grey util.inspect src}"
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
  debug "<- #{chalk.grey util.inspect obj}"
  obj
