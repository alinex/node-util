# Utility functions for array.
# =================================================


# Get the last element of an array
# -------------------------------------------------
#
# __Arguments:__
#
# * `array`
#   of elements to work on
# * `back` (optional)
#   offset character position from the end to look for
#
# __Returns:__
#
# * last element value
exports.last = (array, back) ->
  array[array.length - (back or 0) - 1]

exports.unique = (array) ->
  output = {}
  output[array[key]] = array[key] for key in [0...array.length]
  value for key, value of output

# Add array helpers to the Object class
# -------------------------------------------------
# This will allow to call the methods directly on an object.
exports.addToPrototype = ->
  Array.prototype.last = (back) ->
    exports.last this, back
  Array.prototype.unique = ->
    exports.unique this
