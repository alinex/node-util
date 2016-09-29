###
String Methods
=================================================
###


# Node Modules
# -------------------------------------------------
debug = require('debug') 'util:string'
util = require 'util'


# External Methods
# -------------------------------------------------

###
This is a handy method to check that a certain string starts with the given
phrase.

__Example:__

``` coffee
util = require 'alinex-util'
test = 'abcdefg'
result = util.string.starts test, 'ab'
```

This results to:

    result = true

@param {String} string text to be checked
@param {String} literal phrase to match
@param {Integer} [start] offset character position to start looking for
@return {Boolean} `true` if string starts with literal
###
exports.starts = (string, literal, start) ->
  if debug.enabled
    debug "check #{util.inspect string} to start with #{util.inspect literal}
  #{if start then 'starting at #' + start else ''}"
  literal is string.substr start, literal.length

###
Peek at the end of a given string to see if it matches a sequence.

__Example:__

``` coffee
util = require 'alinex-util'
test = 'abcdefg'
result = util.string.ends test, 'fg'
```

This results to:

    result = true

@param {String} string text to be checked
@param {String} literal phrase to match
@param {Integer} [back] offset character position from the end
@return {Boolean} `true` if string ends with literal
###
exports.ends = (string, literal, back) ->
  if debug.enabled
    debug "check #{util.inspect string} to end with #{util.inspect literal}
  #{if back then 'starting before #' + back else ''}"
  len = literal.length
  literal is string.substr string.length - len - (back or 0), len

###
Repeat a given string multiple times.

__Example:__

``` coffee
util = require 'alinex-util'
test = 'ab'
result = util.string.repeat test, 3
```

This results to:

    result = 'ababab'

@param {String} string phrase to repeat
@param {Integer} num number of repeats to do
@return {String} the repeated text
###
exports.repeat = (string, num) ->
  debug "repeat #{util.inspect string} #{num} times" if debug.enabled
  # use clever algorithm to have O(log(num)) string concatenation operations
  res = ''
  while num > 0
    res += string if num & 1
    num >>>= 1
    string += string
  res

###
Left pad string to specified length.

__Example:__

``` coffee
util = require 'alinex-util'
test = '5'
result = util.string.lpad test, 3, '0'
```

This results to:

    result = '005'

@param {String} string text to be padded
@param {Integer} length final length of text
@param {Character} [char=' '] character used for padding
@return {String} the padded text
###
exports.lpad = (string, length, char = ' ') ->
  if debug.enabled
    debug "left padding #{util.inspect string} with #{util.inspect char} to length of #{length}"
  string = string.toString() unless typeof string is 'string'
  return string unless length >= string.length
  exports.repeat(char, length - string.length) + string

###
Right pad string to specified length.

__Example:__

``` coffee
util = require 'alinex-util'
test = 'abc'
result = util.string.rpad test, 5, ' '
```

This results to:

    result = 'abc  '

@param {String} string text to be padded
@param {Integer} length final length of text
@param {Character} [char=' '] character used for padding
@return {String} the padded text
###
exports.rpad = (string, length, char = ' ') ->
  if debug.enabled
    debug "right padding #{util.inspect string} with #{util.inspect char} to length of #{length}"
  string = string.toString() unless typeof string is 'string'
  return string unless length >= string.length
  string + exports.repeat(char, length - string.length)

###
Center pad string to specified length. This will add the padding on both sides.
For udd number of padding the padding on the right will be one character more as
on the left.

__Example:__

``` coffee
util = require 'alinex-util'
test = 'abc'
result = util.string.cpad test, 5, ' '
```

This results to:

    result = 'abc  '

@param {String} string text to be padded
@param {Integer} length final length of text
@param {Character} [char=' '] character used for padding
@return {String} the padded text
###
exports.cpad = (string, length, char = ' ') ->
  if debug.enabled
    debug "center padding #{util.inspect string} with #{util.inspect char} to length of #{length}"
  string = string.toString() unless typeof string is 'string'
  return string unless length >= string.length
  lpad = exports.repeat char, Math.floor (length - string.length) / 2
  rpad = exports.repeat char, Math.ceil (length - string.length) / 2
  lpad + string + rpad

###
Trim given characters.

__Example:__

``` coffee
util = require 'alinex-util'
test = '/var/local/'
result = util.string.trim test, '/'
```

This results to:

    result = 'var/local'

@param {String} string text to be trimmed
@param {String} [chars=' \n\t'] list of characters to trim off
@return {String} the trimmed text
###
exports.trim = (string, chars = " \n\t") ->
  if debug.enabled
    debug "trim #{util.inspect chars} from  #{util.inspect string}"
  string = string.substring 1 while string and ~chars.indexOf string.charAt 0
  while string and ~chars.indexOf string.charAt string.length-1
    string = string.substring 0, string.length-1
  string

###
Left trim given characters.

__Example:__

``` coffee
util = require 'alinex-util'
test = '/var/local/'
result = util.string.ltrim test, '/'
```

This results to:

    result = 'var/local/'

@param {String} string text to be trimmed
@param {String} [chars=' \n\t'] list of characters to trim off
@return {String} the trimmed text
###
exports.ltrim = (string, chars = " \n\t") ->
  if debug.enabled
    debug "ltrim #{util.inspect chars} from  #{util.inspect string}"
  string = string.substring 1 while string and ~chars.indexOf string.charAt 0
  string

###
Right trim given characters.

__Example:__

``` coffee
util = require 'alinex-util'
test = '/var/local/'
result = util.string.rtrim test, '/'
```

This results to:

    result = '/var/local'

@param {String} string text to be trimmed
@param {String} [chars=' \n\t'] list of characters to trim off
@return {String} the trimmed text
###
exports.rtrim = (string, chars = " \n\t") ->
  if debug.enabled
    debug "rtrim #{util.inspect chars} from  #{util.inspect string}"
  while string and ~chars.indexOf string.charAt string.length-1
    string = string.substring 0, string.length-1
  string

###
Make first letter upper case.

__Example:__

``` coffee
util = require 'alinex-util'
test = 'abcdefg'
result = util.string.ucfirst test
```

This results to:

    result = 'Abcdefg'

@param {String} string text to be changed
@return {String} the text with first letter upper case
###
exports.ucFirst = (string) ->
  if debug.enabled
    debug "upper case first letter of #{util.inspect string}"
  string.charAt(0).toUpperCase() + string.slice(1)

###
Make first letter lower case.

__Example:__

``` coffee
util = require 'alinex-util'
test = 'ABCDEFG'
result = util.string.lcFirst test
```

This results to:

    result = 'aBCDEFG'

@param {String} string text to be changed
@return {String} the text with first letter lower case
###
exports.lcFirst = (string) ->
  if debug.enabled
    debug "lower case first letter of #{util.inspect string}"
  string.charAt(0).toLowerCase() + string.slice(1)

###
Check if string contains substring.

__Example:__

``` coffee
util = require 'alinex-util'
test = 'abcdefg'
result1 = util.string.contains test, 'bc'
result2 = util.string.contains test, 'gh'
```

This results to:

    result1 = true
    result2 = false

@param {String} string text to be checked
@param {String} phrase text to be searched for
@return {Boolean} `true` if phrase is contained in string
###
exports.contains = (string, phrase) ->
  if debug.enabled
    debug "check if #{util.inspect string} contains #{util.inspect phrase}"
  string.indexOf(phrase) isnt -1


###
Word wraps a given text as needed.

__Example:__

``` coffee
util = require 'alinex-util'
test = "All necessary parts are on the same machine, so that you only have to bring this
machine to work. Backups of the data are made on vs10152.
\n\n
Keep in mind that the machine is in the test net and you have to use a valid VPN
connection for accessing.
"""
result = util.string.wordwrap test, 78
```

This results to (variable result):

    All necessary parts are on the same machine, so that you only have to bring
    this machine to work. Backups of the data are made on vs10152.

    Keep in mind that the machine is in the test net and you have to use a valid
    VPN connection for accessing.

@param {String} str
@param {Integer} [width=80] maximum amount of characters per line
@param {String} [brk=\n] string that will be added whenever it's needed to break the line
@return {String} the multiline text
###
exports.wordwrap = (str, width = 80, brk = '\n') ->
  if debug.enabled
    debug "wordwrap to width of #{width} characters (separator is #{util.inspect brk}):
  \n#{str}"
  wrap = ''
  loop
    # check if string to short
    if str.length <= width
      wrap += str
      break
    # check if already has a break
    p = str.indexOf brk
    if -1 < p <= width
      wrap += str[0..p]
      str = str[p+1..]
      continue
    # find possible break in range
    p = width
    p-- while p > 0 and str[p] isnt ' '
    if p > 0
      wrap += str[0..p-1] + brk
      str = str[p+1..]
      continue
    # too long, break on next possition
    p = width
    p++ while p < str.length and str[p] isnt ' '
    if p < str.length
      wrap += str[0..p-1] + brk
      str = str[p+1..]
      continue
    # not possible to break
    wrap += str
    break
  wrap


###
This will shorten the given text and add ellipsis if it is too long. This is done
word aware.

__Example:__

``` coffee
util = require 'alinex-util'
test = """
A high CPU usage means that the server may not start
another task immediately.
If the load is also very high the system is overloaded, check if any application
goes evil.
"""
result = util.string.shorten test, 68
```

This results to (variable result):

    A high CPU usage means that the server may not start...

@param {String} str text to shorten
@param {Integer} limit maximum number of characters
@return {String} shortend text
###
exports.shorten = (str, limit) ->
  if debug.enabled
    debug "shorten to width of #{limit} characters:\n#{str}"
  return str if str.length < limit
  # need to shorten
  str = str[0..limit-3].replace /\s\S*?$/, ''
  return str + '...'

###
Convert text into list or list of array (recordset).

__Example:__

``` coffee
util = require 'alinex-util'
test = 'one,two,three\n1,2,3\n4,5,6'
list = util.string.toList test, /\n/
table = util.string.toList test, /\n/, /,/
```

This results to:

``` coffee
list = [
  'one,teo,three'
  '1,2,3'
  '4,5,6'
]
table = [
  ['one', 'two', 'three']
  ['1', '2', '3']
  ['4', '5', '6']
]
```

@param {String} text data to split
@param {String|RegExp} [rowDelimiter=\n] text or regular expression to divide into lines
@param {String|RegExp\ [colDelimiter] text or regular expression to divide into columns
@return {Array} the new list or list of arrays
###
exports.toList = (text, rowDelimiter = /\n/, colDelimiter) ->
  if debug.enabled
    debug "split to list (#{util.inspect rowDelimiter}/#{util.inspect colDelimiter}):\n#{text}"
  list = text.split rowDelimiter
  return list unless colDelimiter
  list.map (e) -> e.split colDelimiter

###
Convert text into regular expression object if possible.

__Example:__

``` coffee
util = require 'alinex-util'
test = '/\n/'
test = util.string.toRegExp test
list = util.string.split test # use the RegExp
```

@param {String} text to be converted
@return {RegExp|String} regular expression or ioriginal text
###
exports.toRegExp = (text) ->
  debug "try to transform #{util.inspect text} to RegExp" if debug.enabled
  return text unless typeof text is 'string'
  match = text.replace '\t', '\\t'
  .replace '\n', '\\n'
  .replace '\r', '\\r'
  .match /^\/(.*)\/([gim]+)?$/
  return text unless match
  new RegExp match[1], match[2]


###
Debugging
--------------------------------------------------
Debugging is possible using environment setting:

```
DEBUG=util:string    -> each method call
```

###
