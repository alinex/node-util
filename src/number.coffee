# Utility functions for numbers.
# =================================================


# Check that the number is an integer
# -------------------------------------------------
#
# __Arguments:__
#
# * `object`
#   to be analyzed
#
# __Returns:__
#
# * `true` if `object` is an integer
exports.isInteger = isInteger = (object) ->
  object is (object | 0)


# Add object helpers to the Object class
# -------------------------------------------------
# This will allow to call the methods directly on an object.
exports.addToPrototype = ->
  unless Number.isInteger
    Number.prototype.isInteger = isInteger

