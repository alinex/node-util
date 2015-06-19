chai = require 'chai'
expect = chai.expect

describe "Object", ->

  {object} = require '../../src/index'

  describe "clone", ->

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

    it "should clone array of arrays", ->
      test = [ 1,[2],3 ]
      result = object.clone test
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.not.equal test

    it "should clone date", ->
      test = new Date()
      result = object.clone test
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.not.equal test

    it "should clone regexp", ->
      test = /ab/gim
      result = object.clone test
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.not.equal test

    it "should copy instance reference", ->
      test = new Error "Test error"
      result = object.clone test
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.equal test

    it "should clone complex structure", ->
      test =
        eins: 1
        zwei: [2]
        drei: 'drei'
        vier:
          array: [1,2,3]
          error: new Error 'Test error'
          regexp: /ab/
          date: new Date()
      result = object.clone test
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
      expect(result, "deep check").to.deep.equal test
      expect(result, "is cloned").to.not.equal test

    it "should add integer attribute", ->
      test = { eins: 1 }
      result = object.extend test, { drei: 3 }
      expect(result, "equal check").to.equal test
      expect(result, "contains key eins").to.include.keys 'eins'
      expect(result, "contains key drei").to.include.keys 'drei'

    it "should overwrite entry", ->
      test = { eins: 1 }
      result = object.extend test, { eins: 'eins' }
      expect(result, "is changed").to.equal test
      expect(result, "contains key eins").to.include.keys 'eins'
      expect(result.eins, "value changed").to.equal 'eins'

    it "should add multiple extenders", ->
      test = { eins: 1 }
      result = object.extend test, { zwei: 2 }, { eins: 'eins' }, { drei: 3 }
      expect(result, "is changed").to.equal test
      expect(result, "contains key eins").to.include.keys 'eins'
      expect(result, "contains key zwei").to.include.keys 'zwei'
      expect(result, "contains key drei").to.include.keys 'drei'
      expect(result.eins, "value changed").to.equal 'eins'

    it "should extend empty object with 0", ->
      result = object.extend null, 0
      expect(result, "value changed").to.equal 0

    it "should work with toString as name", ->
      test = { toString: 'eins' }
      result = object.extend {}, test
      expect(result, "test-1").to.deep.equal test
      test = { toString: {} }
      result = object.extend {}, test
      expect(result, "test-2").to.deep.equal test

  describe "isempty", ->

    it "should detect empty objects", ->
      expect(object.isempty(null), "null").to.equal true
      expect(object.isempty(undefined), "undefined").to.equal true
      expect(object.isempty([]), "array").to.equal true
      expect(object.isempty({}), "object").to.equal true

    it "should detect not empty objects", ->
      expect(object.isempty([4]), "array").to.equal false
      expect(object.isempty({a:1}), "object").to.equal false

  describe "prototype", ->

    it "should clone object", ->
      object.addToPrototype()
      test = { eins: 1 }
      result = test.clone()
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.not.equal test

    it "should add integer attribute", ->
      object.addToPrototype()
      test = { eins: 1 }
      test.extend { drei: 3 }
      expect(test, "contains key eins").to.include.keys 'eins'
      expect(test, "contains key drei").to.include.keys 'drei'
