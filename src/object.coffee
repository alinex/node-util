# Utility functions.
# =================================================


# Read configuration
# -------------------------------------------------

module.exports.deepExtend = (object, extenders...) ->
  return {} if not object?
  for other in extenders
    for own key, val of other
      if not object[key]? or typeof val isnt "object"
        object[key] = val
      else if val instanceof Date
        object[key] = new Date val.getTime()
      else if val instanceof RegExp
        flags = ''
        flags += 'g' if val.global?
        flags += 'i' if val.ignoreCase?
        flags += 'm' if val.multiline?
        flags += 'y' if val.sticky?
        object[key] = new RegExp(val.source, flags)
      else
        object[key] = deepExtend object[key], val
  object
