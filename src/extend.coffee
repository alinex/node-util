# Utility functions for objects.
# =================================================

# Node modules
# -------------------------------------------------
debug = require('debug')('util:extend')
util = require 'util'
chalk = require 'chalk'
# internal modules
clone = require './clone'


# Indention
# -------------------------------------------------
# Because the function works synchrone, the indent variable can be used accross
# all calls to show the level in the debug messages. It is set to 3 spaces for
# the initial call increased by 3 every subcall.
indent = ''


# Extend object
# -------------------------------------------------
# This method will extend a given object with the entries from additional
# objects. Therefore it will do a deep extend.
#
# __Arguments:__
#
# * `mode`
#   optional string 'MODE ...' defining how the extend should work
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
# __Modes:__
#
# Multiple modes can be used with space as separator:
#
# * `CLONE` - clone object and all extenders before extending, keeps the resulting
#   objects untouched
# * `ARRAY_REPLACE` - for all arrays, replace the previouse array completely instead
#   of extending them
# * `ARRAY_OVERWRITE` - overwrite the same index instead of extending the array
#
# Also it is possible to replace the previous settings on demand. Therefore the
# first element in the array should be 'CLEANUP_BEFORE' or if an object the
# property 'CLENUP_BEFORE' should be set to true.
extend = module.exports = (ext...) ->
  indent += '   '
  # read mode
  mode = []
  if typeof ext[0] is 'string' and ext[0]?.indexOf 'MODE' is 0
    mode = ext.shift().split(' ')
    mode.shift()
  # return if no object given
  return null unless ext.length
  # clone all if defined
  ext = clone ext if 'CLONE' in mode
  # run over extenders
  obj = ext.shift()
  debug "#{indent[3..]}-> extend #{chalk.grey util.inspect obj}"
  debug "#{indent[3..]}   using mode: #{mode.join ', '}"
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
      if 'ARRAY_REPLACE' in mode or not Array.isArray obj
        obj = src
        continue
      if 'ARRAY_OVERWRITE' in mode
        obj[i] = extend "MODE #{mode.join ' '}", obj[i], n for n, i in src
      else
        obj.push n for n in src
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
        if v is null
          delete obj[k]
          continue
        # test to assure a key like 'toString' won't map to the standard function
        obj[k] = if k in Object.keys(obj)
          if mode.length
            extend "MODE #{mode.join ' '}", obj[k], v
          else
            extend obj[k], v
        else
          v
      continue
  # return resulting obj
  indent = indent[3..]
  debug "#{indent}<- #{chalk.grey util.inspect obj}"
  obj
