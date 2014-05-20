# Utility functions.
# =================================================


# Read configuration
# -------------------------------------------------

extend = module.exports.extend = (obj, ext...) ->
#  console.log 'extend', obj, ext
  # clone if no extenders given
  return extend null, obj if not ext?
  obj = {} unless obj
#  console.log ' xtend', obj, ext
  # use all extenders
  for src in ext
#    console.log src.constructor
    continue unless src
    continue if src.constructor? is Object and not Object.keys(src).length
#    console.log 'check', obj, src
    if typeof src isnt 'object'
      obj = src
    else if Array.isArray src
      obj = cloneArray src
    else if src instanceof Date
      obj = cloneDate src
    else if src instanceof RegExp
      obj = cloneRegExp src
    else if obj.constructor? isnt Object
      obj = cloneInstance src
    else
      for key, val of src
        obj[key] = extend obj[key], val
#  console.log 'result', obj
  obj

module.exports.clone = (object) ->
  extend null, object

cloneRegExp = (obj) ->
  flags = ''
  flags += 'g' if obj.global
  flags += 'i' if obj.ignoreCase
  flags += 'm' if obj.multiline
  flags += 'y' if obj.sticky
  new RegExp obj.source, flags

cloneArray = (obj) ->
  obj.slice 0

cloneDate = (obj) ->
  new Date obj.getTime()

cloneInstance = (obj) ->
  res = obj.constructor()
  for own key, val of obj
    res[key] = extend null, val
  res
