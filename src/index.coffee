# Utility functions.
# =================================================

# http://coffeescript.org/documentation/docs/helpers.html

# Load helpers for each category
# -------------------------------------------------
module.exports.string = require './string'
module.exports.object = require './object'


# Add all helpers to the corresponding class
# -------------------------------------------------
# This will allow to call the methods directly on an object.
module.exports.addToPrototype = ->
  module.exports.string.addToPrototype()
  module.exports.object.addToPrototype()