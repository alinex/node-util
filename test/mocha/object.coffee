chai = require 'chai'
expect = chai.expect

describe "Object", ->

  {object} = require '../../src/index'

  describe.only "clone", ->

    it "should clone object", ->
      test = { eins: 1 }
      result = object.clone test
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.not.equal test

    it "should clone string", ->
      test = "eins"
      result = object.clone test
      expect(result, "deep check").to.deep.equal test

    it "should clone array", ->
      test = [ 1,2,3 ]
      result = object.clone test
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.not.equal test

    it "should clone date", ->
      test = new Date()
      result = object.clone test
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.not.equal test

    it "should clone regexp", ->
      test = /ab/
      result = object.clone test
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.not.equal test

    it "should clone instance", ->
      test = new Error "Test error"
      result = object.clone test
      console.log result
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.not.equal test

  describe "extend", ->

    it "should clone object", ->
      test = { eins: 1 }
      result = object.extend null, test
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.not.equal test

    it "should let object untouched for empty extenders", ->
      test = { eins: 1 }
      orig = object.extend null, test
      object.extend test, {}
      expect(test, "deep check").to.deep.equal orig
      expect(test, "reference").to.not.equal orig
      test = object.extend test, {}
      expect(test, "deep check").to.deep.equal orig
      expect(test, "reference").to.not.equal orig
      test = object.extend test
      expect(test, "deep check").to.deep.equal orig
      expect(test, "reference").to.not.equal orig

    it "should clone into empty object", ->
      test = { eins: 1 }
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

