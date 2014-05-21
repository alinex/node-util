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
      test = /ab/
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

