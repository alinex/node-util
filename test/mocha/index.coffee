chai = require 'chai'
expect = chai.expect
### eslint-env node, mocha ###

describe "Util", ->

  util = require '../../src/index'

  describe "inspect", ->

    it "should work on string", ->
      expect util.inspect null
      .to.equal "null"

    it "should work on arrays", ->
      expect util.inspect [1, 2, 3, 4, 5]
      .to.equal "[ 1, 2, 3, 4, 5 ]"

    it "should work on object", ->
      expect util.inspect {eins: 1}
      .to.equal "{ eins: 1 }"
