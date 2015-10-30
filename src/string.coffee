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
  return string unless length > string.length
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
  return string unless length > string.length
  string + exports.repeat(char, length - string.length)

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
# - cutType
#   0 = words longer than "maxLength" will not be broken
#   1 = words will be broken when needed
#   2 = any word that trespass the limit will be broken
exports.wordwrap = (str, width = 80, brk = '\n', cut = 1) ->
  return str unless str and width
  l = (r = str.split("\n")).length
  i = -1
  while ++i < l
    s = r[i]
    r[i] = ""
    while s.length > width
      j = (if cut is 2 or (j = s.slice(0, width + 1).match(/\S*(\s)?$/))[1] then \
      width else j.input.length - j[0].length or cut is 1 and m or \
      j.input.length + (j = s.slice(m).match(/^\S*/)).input.length)
      r[i] += s.slice(0, j) + ((if (s = s.slice(j)).length then brk else ""))
    r[i] += s
  r.join "\n"

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
  String.prototype.ucFirst = ->
    exports.ucFirst this
  String.prototype.lcFirst = ->
    exports.lcFirst this
  String.prototype.contains = (phrase) ->
    exports.contains this, phrase
  String.prototype.wordwrap = (width, brk, cut) ->
    exports.contains this, width, brk, cut
