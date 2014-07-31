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

# Read time interval in seconds
# -------------------------------------------------
# With this parser it is possible to read a time interval in human format
# like: `1h 30m`.
#
# __Arguments:__
#
# * `value`
#   to be analyzed
#
# __Returns:__
#
# * `value` as Number or `NaN`
exports.parseSeconds = (value) ->
  int = parseInteger value
  return int unless isNaN int
  int = 0
  for part in value.toLowerCase().split /\s+/
    match = /^(\d+(?:\.\d+)?)\s*([smhd])$/.exec part
    return NaN unless match
    value = parseFloat match[1]
    int += switch match[2]
      when 's' then value
      when 'm' then value * 60
      when 'h' then value * 3600
      when 'd' then value * 24 * 3600
  Math.floor int

# Read time interval in mmilliseconds
# -------------------------------------------------
# With this parser it is possible to read a time interval in human format
# like: `1h 30m`.
#
# __Arguments:__
#
# * `value`
#   to be analyzed
#
# __Returns:__
#
# * `value` as Number or `NaN`
exports.parseMSeconds = (value) ->
  int = parseInteger value
  return int unless isNaN int
  int = 0
  for part in value.toLowerCase().split /\s+/
    match = /^(\d+(?:\.\d+)?)\s*([smhd]|ms)$/.exec part
    return NaN unless match
    value = parseFloat match[1]
    int += switch match[2]
      when 'ms' then value
      when 's' then value * 1000
      when 'm' then value * 60000
      when 'h' then value * 3600000
      when 'd' then value * 24 * 3600000
  Math.floor int

# Add object helpers to the Object class
# -------------------------------------------------
# This will allow to call the methods directly on an object.
exports.addToPrototype = ->
  unless Number.isInteger
    Number.prototype.isInteger = isInteger
  Number.prototype.parseInt = parseInteger
  Number.prototype.parseSeconds = parseSeconds
