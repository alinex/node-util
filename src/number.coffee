# Utility functions for numbers.
# =================================================


# Check for integer
# -------------------------------------------------
# This method will check that the given value is an integer .
#
# __Arguments:__
#
# * `value`
#   to be analyzed
#
# __Returns:__
#
# * `true` if `value` is an integer
exports.isInteger = isInteger = (value) ->
  value is (value | 0)

# Stricter parse function
# -------------------------------------------------
# This will fail on all strings which are no real integer.
#
# __Arguments:__
#
# * `value`
#   to be analyzed
#
# __Returns:__
#
# * `value` as Number or `NaN`
exports.parseInt = parseInteger = (value) ->
  return Number value if /^(\-|\+)?([0-9]+|Infinity)$/.test value
  NaN

# Add object helpers to the Object class
# -------------------------------------------------
# This will allow to call the methods directly on an object.
exports.addToPrototype = ->
  unless Number.isInteger
    Number.prototype.isInteger = isInteger
  Number.prototype.parseInt = parseInteger
