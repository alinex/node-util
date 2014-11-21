# Utility functions for objects.
# =================================================


# Extend object
# -------------------------------------------------
# This method will extend a given object with the entries from additional
# objects. Therefore it will do a deep extend.
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
extend = module.exports.extend = (obj, ext...) ->
  # clone if no extenders given
  return extend null, obj if not ext?
  obj = null unless obj
  # use all extenders
  for src in ext
    continue unless src?
    continue if src.constructor? is Object and not Object.keys(src).length
    obj = {} unless obj
    if typeof src isnt 'object'
      # simple variables or function
      obj = src
    else if Array.isArray src
      # array
      res = []
      for own key, val of src
        res.push extend obj[key]?, src[key]
      obj = res
    else if src instanceof Date
      obj = new Date src.getTime()
    else if src instanceof RegExp
      flags = ''
      flags += 'g' if src.global
      flags += 'i' if src.ignoreCase
      flags += 'm' if src.multiline
      flags += 'y' if src.sticky
      obj = new RegExp src.source, flags
    else if src.constructor != Object
#     exact copy/clone not working on instances
#      obj = extendInstance obj, src
      obj = src
    else
      # object structure
      for key, val of src
        obj[key] = extend obj[key], val
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

extendInstance = (obj, src) ->
  res = src.constructor()
  for own key, val of src
    res[key] = extend obj[key], val
  res

# Add object helpers to the Object class
# -------------------------------------------------
# This will allow to call the methods directly on an object.
module.exports.addToPrototype = ->
  Object.prototype.extend = (args...) ->
    args.unshift this
    extend.apply null, args
  Object.prototype.clone = ->
    extend null, this
