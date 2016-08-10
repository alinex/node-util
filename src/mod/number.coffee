###
Number Methods
=================================================
###


# Exported Methods
# ------------------------------------------------

###
This method will check that the given value is an integer.

@param value the number to check
@return {Boolean} `true` if `value` is an integer
###
exports.isInteger = (value) ->
  value is (value | 0)

###
This method will check that the given value is a number.

@param value the number to check
@return {Boolean} `true` if `value` is a number
###
exports.isNumber = (value) ->
  not(isNaN parseFloat value) and isFinite value

###
Strict parsing of numbers.
This will fail on all strings which are no real integer.

@param value the number to check
@return {Number} value as Number or `NaN`
@see To check if you got a number or invalid string use {@link isNaN()}.
###
exports.parseInt = parseInteger = (value) ->
  return Number value if /^(\-|\+)?([0-9]+|Infinity)$/.test value
  NaN

###
Parse human readable time to seconds.
With this parser it is possible to read a time interval in human format
like: `1h 30m`.

__Example:__

``` coffee
number.parseSeconds 200          # 200
number.parseSeconds '200s'       # 200
number.parseSeconds '200S'       # 200
number.parseSeconds '5m'         # 300
number.parseSeconds '1h'         # 3600
number.parseSeconds '2.5h'       # 9000
number.parseSeconds '1d'         # 86400
number.parseSeconds '2h 5m 100s' # 7600
```

@param {String} value the time to transform into seconds
@return {Number} value as Number or `NaN`
@see {@link parseMSeconds}
@description
To check if you got a number or invalid string use `isNaN()`.
###
exports.parseSeconds = (value) ->
  int = parseInteger value
  return int unless isNaN int
  return NaN unless typeof value is 'string'
  int = 0
  for part in value.toLowerCase().replace(/([smhd])(\d)/g, '$1 $2').split /\s+/
    match = /^([+-]?\d+(?:\.\d+)?)\s*([smhd])$/.exec part
    return NaN unless match
    value = parseFloat match[1]
    int += switch match[2]
      when 's' then value
      when 'm' then value * 60
      when 'h' then value * 3600
      when 'd' then value * 24 * 3600
  Math.floor int

###
Parse human readable time to milliseconds. It will work the same as above and
you may specify `ms` as additional unit here.

@param {String} value the time to transform into seconds
@return {Number} value as Number or `NaN`
@see {@link parseSeconds}
@description
To check if you got a number or invalid string use `isNaN()`.
###
exports.parseMSeconds = (value) ->
  int = parseInteger value
  return int unless isNaN int
  return NaN unless typeof value is 'string'
  int = 0
  for part in value.toLowerCase().replace(/([smhd])(\d)/g, '$1 $2').split /\s+/
    match = /^([+-]?\d+(?:\.\d+)?)\s*([smhd]|ms)$/.exec part
    return NaN unless match
    value = parseFloat match[1]
    int += switch match[2]
      when 'ms' then value
      when 's' then value * 1000
      when 'm' then value * 60000
      when 'h' then value * 3600000
      when 'd' then value * 24 * 3600000
  Math.floor int
