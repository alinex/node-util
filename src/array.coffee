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

# remove duplicates
# -------------------------------------------------
exports.unique = (array) ->
  output = {}
  output[JSON.stringify array[key]] = array[key] for key in [0...array.length]
  value for key, value of output

# Sort array of objects
# -------------------------------------------------
exports.sortBy = (array) ->
  args = [].slice.call arguments
  switch args.length
    when 1
      throw new Error "Missing sort column name."
    when 2
      array.sort dynamicSort args[1]
    else
      array.sort dynamicMultiSort.apply this, args[1..]


# Helper Methods
# -------------------------------------------------

dynamicSort = (field) ->
  sortOrder = 1
  if field[0] is '-'
    sortOrder = -1
    field = field.substr 1
  # return sort function
  (a, b) ->
    result = if a[field] < b[field] then -1 else if a[field] > b[field] then 1 else 0
    result * sortOrder

dynamicMultiSort = ->
  args = [].slice.call(arguments)
  fields = args.map (e) -> dynamicSort e
  # return sort function
  (a, b) ->
    result = 0
    for sort in fields
      result = sort a, b
      return result if result
    result
