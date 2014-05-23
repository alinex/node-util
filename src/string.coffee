# Utility functions for strings.
# =================================================


# Check for specific string start
# -------------------------------------------------
# Peek at the beginning of a given string to see if it matches a sequence.
#
# __Arguments:__
#
# * `string`
#   text to be checked
# * `literal`
#   phrase to match
# * `start` (optional)
#   offset character position to start looking for
#
# __Returns:__
#
# * `true` if `string` starts with `literal`
module.exports.starts = (string, literal, start) ->
  literal is string.substr start, literal.length

# Check for specific string ending
# -------------------------------------------------
# Peek at the end of a given string to see if it matches a sequence.
#
# __Arguments:__
#
# * `string`
#   text to be checked
# * `literal`
#   phrase to match
# * `back` (optional)
#   offset character position from the end to look for
#
# __Returns:__
#
# * `true` if `string` ends with `literal`
exports.ends = (string, literal, back) ->
  len = literal.length
  literal is string.substr string.length - len - (back or 0), len

# Add object helpers to the Object class
# -------------------------------------------------
# This will allow to call the methods directly on an object.
module.exports.addToPrototype = ->
  String.prototype.starts = (literal, start) ->
    mosule.exports.starts this, literal, start

