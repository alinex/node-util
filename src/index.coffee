###
API Usage
=================================================
This module exports different modules to be used alltogether or singular.

Three methods which are usable for all types are directly accessible in the main
module:
- {@link util.inspect inspect()} - direct use of the NodeJS core method
- {@link clone.coffee clone} - make a deep clone
- {@link extend.coffee extend} - extend objects by mapping other ones into this

All other helper are used through a collection named after their type:
- {@link string.coffee string} - methods for working with `String` objects
- {@link object.coffee object} - methods for working with `Object` objects
- {@link array.coffee array} - methods for working with `Array` objects
- {@link number.coffee number} - methods for working with `Number` objects
- {@link function.coffee function} - methods for working with `Function` objects


Debugging
--------------------------------------------------
This module uses the {@link debug} module so you may anytime call your app with
the environment setting `DEBUG=util:*` but keep in mind that this will output a
lot of information. So better use the concrete setting in each module. Most have one
defined with their name:

    DEBUG=util:*      -> complete util package
    DEBUG=util:clone  -> only clone method
    DEBUG=util:extend -> only extend method

This should output something like (from clone method) on STDERR:

    util:clone -> { maxCpu: '95%', maxLoad: '400%' } +0ms
    util:clone    ++ [] +0ms
    util:clone    -> '95%' +0ms
    util:clone    <- is primitive +0ms
    util:clone    -> '400%' +0ms
    util:clone    <- is primitive +0ms
    util:clone <- cloned object +0ms
    util:clone -> { nice: -20 } +0ms
    util:clone    ++ [] +0ms
    util:clone    -> -20 +0ms
    util:clone    <- is primitive +0ms
    util:clone <- cloned object +0ms
###


# Load helpers for each category
# -------------------------------------------------
module.exports =
  # general methods
  inspect: require('util').inspect
  clone: require './mod/clone'
  extend: require './mod/extend'
  # for specific objects
  string: require './mod/string'
  object: require './mod/object'
  array: require './mod/array'
  number: require './mod/number'
  function: require './mod/function'
