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
exports.starts = (string, literal, start) ->
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

# Repeat string n times
# -------------------------------------------------
# Use clever algorithm to have O(log(n)) string concatenation operations.
exports.repeat = (str, n) ->
  res = ''
  while n > 0
    res += str if n & 1
    n >>>= 1
    str += str
  res

# Add object helpers to the Object class
# -------------------------------------------------
# This will allow to call the methods directly on an object.
exports.addToPrototype = ->
  String.prototype.starts = (literal, start) ->
    exports.starts this, literal, start
  String.prototype.ends = (literal, back) ->
    exports.ends this, literal, back
  String.prototype.repeat = (n) ->
    exports.repeat this, n
