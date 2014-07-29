# Utility functions.
# =================================================

# http://coffeescript.org/documentation/docs/helpers.html

# Load helpers for each category
# -------------------------------------------------
module.exports.string = require './string'
module.exports.object = require './object'
module.exports.array = require './array'
module.exports.number = require './number'


# Add all helpers to the corresponding class
# -------------------------------------------------
# This will allow to call the methods directly on an object.
module.exports.addToPrototype = ->
  module.exports.string.addToPrototype()
  module.exports.object.addToPrototype()
  module.exports.array.addToPrototype()
  module.exports.number.addToPrototype()
