# Utility functions for objects.
# =================================================

debug = require('debug')('util:extend')
util = require 'util'
chalk = require 'chalk'

clone = require './clone'

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
# 'MODE CLONE ARRAY_REPLACE' as first element
indent = ''

extend = module.exports = (obj, ext...) ->
  indent += '   '
  # read mode
  mode = []
  if typeof ext[0] is 'string' and ext[0]?.indexOf 'MODE' is 0
    mode = ext.shift().split(' ')
    mode.shift()
  # clone all if defined
  if 'CLONE' in mode
    obj = clone obj
    ext = clone ext
  # return if no extenders given
  return obj if not ext?
  # run over extenders
  obj = null unless obj
  debug "#{indent[3..]}-> extend #{chalk.grey util.inspect obj}"
  # use all extenders
  for src in ext
    continue unless src?
    # empty source object
    continue if src.constructor?.name is Object.name and not Object.keys(src).length
    debug "#{indent[3..]}   by #{chalk.grey util.inspect src}"
    # undefined object
    unless obj?
      obj = src
      continue
    # arrays
    if Array.isArray src
      if src[0]? is 'CLEANUP_BEFORE'
        obj = src
        obj.shift()
        continue
      if not Array.isArray obj or 'ARRAY_REPLACE' in mode
        obj = src
        continue
      obj.push n for n in obj
      continue
    # all other
    unless typeof src is 'object'
      obj = src
      continue
    # check that this is a literal
    if not src.prototype
      if src.CLEANUP_BEFORE
        obj = src
        delete obj.CLEANUP_BEFORE
        continue
      if not obj? or Array.isArray obj or not typeof obj is 'object'
        obj = src
        continue
      for own k, v of src
        # test to assure a key like 'toString' won't map to the standard function
        base = if k in Object.keys(obj) then obj[k] else undefined
        obj[k] = extend mode, base, v
        delete obj[k] if v is null
      continue
  # return resulting obj
  debug "#{indent[3..]}<- #{chalk.grey util.inspect obj}"
  indent = indent[3..]
  obj
