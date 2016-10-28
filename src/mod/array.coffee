###
Array Methods
=================================================
###

###
Get the last element.

__Example:__

``` coffee
util = require 'alinex-util'
test = [ 1,2,3,4,5 ]
result = util.array.last test
```

This results to:

``` coffee
result = 5
```

@param {Array} array to read from
@param {Integer} back offset character position from the end to look for
@return last element value
###
exports.last = (array, back) ->
  array[array.length - (back or 0) - 1]

###
Remove duplicate entries from array.

__Example:__

``` coffee
util = require 'alinex-util'
test = [ 1,2,2,3,4,1,5 ]
result = util.array.unique test
```

This results to:

``` coffee
result = [1,2,3,4,5]
```

@param {Array} array to to be checked
@return {Array} new array with duplicates removed
###
exports.unique = (array) ->
  output = {}
  output[JSON.stringify array[key]] = array[key] for key in [0...array.length]
  value for _, value of output

###
Sort array of objects.

__Example:__

``` coffee
util = require 'alinex-util'
test = [
  {first: 'Johann Sebastion', last: 'Bach'}
  {first: 'Wolfgang Amadeus', last: 'Mozart'}
  {first: 'Joseph', last: 'Haydn'}
  {first: 'Richard', last: 'Wagner'}
  {first: 'Antonio', last: 'Vivaldi'}
  {first: 'Michael', last: 'Haydn'}
  {first: 'Franz', last: 'Schubert'}
]
# sort by last name ascending and first name descending
result = util.array.sortBy test, 'last', '-first'
```

This results to:

``` coffee
result = [
  {first: 'Johann Sebastion', last: 'Bach'}
  {first: 'Michael', last: 'Haydn'}
  {first: 'Joseph', last: 'Haydn'}
  {first: 'Wolfgang Amadeus', last: 'Mozart'}
  {first: 'Franz', last: 'Schubert'}
  {first: 'Antonio', last: 'Vivaldi'}
  {first: 'Richard', last: 'Wagner'}
]
```

Like displayed above you may give one or multiple field names to sort by the
earlier has precedence. If field name starts with '-' sign it will sort in
descending order.

@param {Array<Object>} array to to be checked
@param {String} sort... sort column name (if prepended with '-' it will sort in
descending order)
@return {Array<Object>} new array in sorted order
@throw {Error} Missing sort column name.
###
exports.sortBy = (array) ->
  args = [].slice.call arguments
  switch args.length
    when 1
      throw new Error "Missing sort column name."
    when 2
      array.sort dynamicSort args[1]
    else
      array.sort dynamicMultiSort.apply this, args[1..]

###
Shuffle elements. But this only works if the array has more than two elements within
else it will be kept unchanged.

__Example:__

``` coffee
util = require 'alinex-util'
util.array.shuffle [1..9]
# => [ 3, 1, 5, 6, 4, 8, 2, 9, 7 ]
```

@param {Array} array to to be shuffled
@return {Array} the same array
###
exports.shuffle = (source) ->
  # arrays with < 2 elements do not shuffle well. Instead make it a noop
  return source unless source.length >= 2
  # From the end of the list to the beginning, pick element `index`.
  for i in [source.length-1..1]
    # Choose random element `r` to the front of `i` to swap with.
    r = Math.floor Math.random() * (i + 1)
    # Swap `r` with `i`, using destructured assignment
    [source[i], source[r]] = [source[r], source[i]]
  source


# Helper Methods
# -------------------------------------------------

# Sort comparator using the given Object column.
#
# @param {String} column name to sort after
# @return {Integer} how to sort
# -1 - correct order
# 0 - equal values
# 1 - change order
dynamicSort = (field) ->
  sortOrder = 1
  if field[0] is '-'
    sortOrder = -1
    field = field.substr 1
  # return sort function
  (a, b) ->
    result = if a[field] < b[field] then -1 else if a[field] > b[field] then 1 else 0
    result * sortOrder

# Sort comparator supporting multiple columns.
#
# @param {String} column... name to sort after
# @return {Integer} how to sort
# -1 - correct order
# 0 - equal values
# 1 - change order
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
