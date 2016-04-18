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
#   objects untouched (works only globally)
# * `ARRAY_CONCAT` - (default) if no other array-mode set, will concat additional
#   elements
# * `ARRAY_REPLACE` - for all arrays, replace the previouse array completely instead
#   of extending them
# * `ARRAY_OVERWRITE` - overwrite the same index instead of extending the array
# * `OBJECT_EXTEND` - (default) if no other object-mode given, will add/replace
#   properties with the new ones
# * `OBJECT_REPLACE` - will always replace the object completely with the new one,
#   if the keys are different
#
# This mode may also be changed on any specific element by giving a different mode
# just for this operation in the extending element itself. Therefore an array
# should has the mode as first element or an object as an attribute.
#
# ``` coffee
# test1 = {a: [1, 2, 3], b: [1, 2, 3], c: [1, 2, 3]}
# test2 = {a: ['MODE ARRAY_REPLACE', 4, 5, 6], b: [4, 5, 6], c: ['a']}
# ext = extend test1, test2
# ```
extend = module.exports = (ext...) ->
  indent += '   '
  # read mode
  mode = []
  if typeof ext[0] is 'string' and ext[0]?.indexOf 'MODE' is 0
    mode = ext.shift().split(' ')[1..]
  # return if no object given
  return null unless ext.length
  # clone all if defined, and remove flag
  ext = clone ext if 'CLONE' in mode
  mode = mode.filter (e) -> e isnt 'CLONE'
  # run over extenders
  obj = ext.shift()
  debug "#{indent[3..]}-> extend #{chalk.grey util.inspect obj}"
  debug "#{indent[3..]}   using mode: #{mode.join ', '}" if mode.length
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
      # check for changed mode
      cmode = if typeof src[0] is 'string' and src[0][0..4] is 'MODE '
        n = src.shift().split(' ')[1..]
        debug "#{indent[3..]}   change mode: #{n.join ', '}"
        n
      else mode
      # extend depending on mode
      if 'ARRAY_REPLACE' in cmode or not Array.isArray obj
        obj = src
        continue
      if 'ARRAY_OVERWRITE' in cmode
        obj[i] = extend "MODE #{mode.join ' '}", obj[i], n for n, i in src
        continue
      # default setting ARRAY_CONCAT
      obj.push n for n in src
      continue
    # all other
    unless typeof src is 'object'
      obj = src
      continue
    # this is a literal
    # check for changed mode
    cmode = mode
    if src.OBJECT_REPLACE
      cmode = ['OBJECT_REPLACE']
      delete src.OBJECT_REPLACE
      debug "#{indent[3..]}   change mode: #{cmode.join ', '}"
    # replace if different type
    if not(obj?) or Array.isArray(obj) or typeof obj isnt 'object' or
    obj.constructor.name isnt Object.name
      obj = src
      continue
    # replace object
    if 'OBJECT_REPLACE' in cmode and Object.keys(obj).join(',') isnt Object.keys(src).join(',')
      obj = src
      continue
    # extend based on OBJECT_EXTEND mode
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
  # return resulting obj
  indent = indent[3..]
  debug "#{indent}<- #{chalk.grey util.inspect obj}"
  obj
