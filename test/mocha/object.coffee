chai = require 'chai'
expect = chai.expect

describe "Object", ->

  {object} = require '../../src/index'

  test = {}
  beforeEach ->
    test =
      one: 1
      two: 2
      string: 'Hello'
      array: [1,2,3]
      re: /a.*/
      date: new Date()

  describe "extend", ->

    it "should let object untouched for empty extenders", ->
      result = object.extend test, {}
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.equal test

    it.only "should clone into empty object", ->
      result = object.extend {}, test
      console.log result, test
      expect(result, "deep check").to.deep.equal test
      expect(result, "is copied").to.not.equal test
      expect(result.array, "copy of array").to.not.equal test.array
      expect(result.array, "equal array").to.equal test.array
      expect(result.re, "copy of RegExp").to.not.equal test.re
      expect(result.date, "copy of date").to.not.equal test.date

    it "should add integer attribute", ->
      result = object.extend test, { three: 3 }
      console.log result
      expect(result).to.equal test
      expect(result).to.include.keys 'three'

