# Utility functions.
# =================================================


# Load helpers for each category
# -------------------------------------------------
module.exports =
  # general methods
  inspect: require('util').inspect
  clone: require './clone'
  extend: require './extend'
  # for specific objects
  string: require './string'
  object: require './object'
  array: require './array'
  number: require './number'
