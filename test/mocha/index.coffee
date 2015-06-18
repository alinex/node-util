chai = require 'chai'
expect = chai.expect

describe "Utils", ->

  utils = require '../../src/index'

  describe "prototype", ->

    it "should work on string", ->
      utils.addToPrototype()
      expect 'hello'.contains 'll'
      , "use hello"
      .to.be.true

    it "should work on arrays", ->
      utils.addToPrototype()
      test = [ 1,2,3,4,5 ]
      expect test.last()
      , "get last"
      .to.be.equal 5

    it "should work on object", ->
      utils.addToPrototype()
      test = { eins: 1 }
      result = test.clone()
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.not.equal test

