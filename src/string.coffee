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

# Left pad string to specified length
# -------------------------------------------------
#
# __Arguments:__
#
# * `string`
#   text to be padded
# * `n`
#   final length of text
# * `char`
#   character used for padding (defaults to ' ')
#
# __Returns:__
#
# * the padded text
exports.lpad = (string, length, char = ' ') ->
  string = string.toString() unless typeof string is 'string'
  return string unless length >= string.length
  exports.repeat(char, length - string.length) + string

# Right pad string to specified length
# -------------------------------------------------
#
# __Arguments:__
#
# * `string`
#   text to be padded
# * `n`
#   final length of text
# * `char`
#   character used for padding (defaults to ' ')
#
# __Returns:__
#
# * the padded text
exports.rpad = (string, length, char = ' ') ->
  string = string.toString() unless typeof string is 'string'
  return string unless length >= string.length
  string + exports.repeat(char, length - string.length)

# Center pad string to specified length
# -------------------------------------------------
#
# __Arguments:__
#
# * `string`
#   text to be padded
# * `n`
#   final length of text
# * `char`
#   character used for padding (defaults to ' ')
#
# __Returns:__
#
# * the padded text
exports.cpad = (string, length, char = ' ') ->
  string = string.toString() unless typeof string is 'string'
  return string unless length >= string.length
  lpad = exports.repeat char, Math.floor (length - string.length) / 2
  rpad = exports.repeat char, Math.ceil (length - string.length) / 2
  lpad + string + rpad

# Trim given characters
# -------------------------------------------------
#
# __Arguments:__
#
# * `string`
#   text to be trimmed
# * `chars`
#   list of characters to trim off (defaults to ' \n\t')
#
# __Returns:__
#
# * the padded text
exports.trim = (string, chars = " \n\t") ->
  string = string.substring 1 while string and ~chars.indexOf string.charAt 0
  while string and ~chars.indexOf string.charAt string.length-1
    string = string.substring 0, string.length-1
  string

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

# Check if string contains substring
# -------------------------------------------------
# __Arguments:__
#
# * `string`
#   text to be check
# * `phrase`
#   text to be searched for
#
# __Returns:__
#
# * (bool) `true` if phrase is contained in string
exports.contains = (string, phrase) ->
  string.indexOf(phrase) isnt -1

# ### WordWrap
#
# - width -
#   maximum amount of characters per line
# - break
#   string that will be added whenever it's needed to break the line
exports.wordwrap = wordwrap = (str, width = 80, brk = '\n') ->
  # check if string to short
  return str if str.length <= width
  # check if already has a break
  p = str.indexOf brk
  if -1 < p <= width
    return str.substring(0, p+1) + wordwrap str.substring(p + 1), width, brk
  # find possible break in range
  p = width
  p-- while p > 0 and str[p] isnt ' '
  if p > 0
    return str.substring(0, p) + brk + wordwrap str.substring(p + 1), width, brk
  # too long, break on next possition
  p = width
  p++ while p < str.length and str[p] isnt ' '
  if p < str.length
    return str.substring(0, p) + brk + wordwrap str.substring(p + 1), width, brk
  # not possible to break
  str

# ### Shorten
#
# - limit
#   maximum number of characters
exports.shorten = (str, limit) ->
  return str if str.length < limit
  # need to shorten
  str = str[0..limit-3].replace /\s\S*?$/, ''
  return str + '...'

# ### Convert to list
exports.toList = (text, rowDelimiter = /\n/, colDelimiter) ->
  list = text.split rowDelimiter
  return list unless colDelimiter
  list.map (e) -> e.split colDelimiter


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
  String.prototype.rpad = (n, char) ->
    exports.rpad this, n, char
  String.prototype.lpad = (n, char) ->
    exports.lpad this, n, char
  String.prototype.cpad = (n, char) ->
    exports.cpad this, n, char
  String.prototype.ucFirst = ->
    exports.ucFirst this
  String.prototype.lcFirst = ->
    exports.lcFirst this
  String.prototype.contains = (phrase) ->
    exports.contains this, phrase
  String.prototype.wordwrap = (width, brk, cut) ->
    exports.wordwrap this, width, brk, cut
  String.prototype.shorten = (limit) ->
    exports.shorten this, limit
  String.prototype.toList = (rowDelimiter, colDelimiter) ->
    exports.toList this, rowDelimiter, colDelimiter
