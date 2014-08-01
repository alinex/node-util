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
#
# __Arguments:__
#
# * `string`
#   text to be repeated
# * `n`
#   number of repeats
#
# __Returns:__
#
# * the repeated text
exports.repeat = (string, n) ->
  res = ''
  while n > 0
    res += string if n & 1
    n >>>= 1
    string += string
  res

# Upper case first character
# -------------------------------------------------
# __Arguments:__
#
# * `string`
#   text to be changed
#
# __Returns:__
#
# * the text with first letter upper case
exports.ucFirst = (string) ->
  string.charAt(0).toUpperCase() + string.slice(1)

# Lower case first character
# -------------------------------------------------
# __Arguments:__
#
# * `string`
#   text to be changed
#
# __Returns:__
#
# * the text with first letter lower case
exports.lcFirst = (string) ->
  string.charAt(0).toLowerCase() + string.slice(1)

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
  String.prototype.ucFirst = ->
    exports.ucFirst this
  String.prototype.lcFirst = ->
    exports.lcFirst this
