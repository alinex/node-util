chai = require 'chai'
expect = chai.expect
### eslint-env node, mocha ###

{extend} = require '../../src/index'

describe "Extend", ->

  describe "default mode", ->

    it "should keep object if only one", ->
      test = null
      result = extend test
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.equal test
      test = {eins: 1}
      result = extend test
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.equal test

    it "should keep object if empty ones added", ->
      test = null
      result = extend test, null, undefined
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.equal test
      test = {eins: 1}
      result = extend test, null, undefined
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.equal test

    it "should keep object if empty ones before", ->
      test = null
      result = extend null, undefined, test
      expect(result, "deep check 1").to.deep.equal test
      expect(result, "reference 1").to.equal test
      test = {eins: 1}
      result = extend null, undefined, test
      expect(result, "deep check 2").to.deep.equal test
      expect(result, "reference 2").to.equal test

    it "should add integer attribute", ->
      test = {eins: 1}
      result = extend test, {drei: 3}
      expect(result, "equal check").to.equal test
      expect(result, "contains key eins").to.include.keys 'eins'
      expect(result, "contains key drei").to.include.keys 'drei'

    it "should overwrite entry", ->
      test = {eins: 1}
      result = extend test, {eins: 'eins'}
      expect(result, "is changed").to.equal test
      expect(result, "contains key eins").to.include.keys 'eins'
      expect(result.eins, "value changed").to.equal 'eins'

    it "should add multiple extenders", ->
      test = {eins: 1}
      result = extend test, {zwei: 2}, {eins: 'eins'}, {drei: 3}
      expect(result, "is changed").to.equal test
      expect(result, "contains key eins").to.include.keys 'eins'
      expect(result, "contains key zwei").to.include.keys 'zwei'
      expect(result, "contains key drei").to.include.keys 'drei'
      expect(result.eins, "value changed").to.equal 'eins'

    it "should extend empty object with 0", ->
      result = extend null, 0
      expect(result, "value changed").to.equal 0

    it "should work with toString as name", ->
      test = {toString: 'eins'}
      result = extend {}, test
      expect(result, "test-1").to.deep.equal test
      test = {toString: {}}
      result = extend {}, test
      expect(result, "test-2").to.deep.equal test

    it "should remove key if set to null", ->
      base = {eins: 1}
      test = {eins: null, zwei: 2}
      result = extend base, test
      expect(result, "deep check").to.deep.equal {zwei: 2}

  describe "clone mode", ->

    it "should clone object", ->
      test = null
      result = extend 'MODE CLONE', test
      expect(result, "deep check").to.deep.equal test
      test = {eins: 1}
      result = extend 'MODE CLONE', test
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.not.equal test

    it "should let object untouched for empty extenders", ->
      test = {eins: 1}
      result = extend 'MODE CLONE', null, test
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.not.equal test
      test = extend 'MODE CLONE', test, {}
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.not.equal test
      test = extend 'MODE CLONE', test
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.not.equal test

    it "should make clone array elements", ->
      test1 = [{one: 'eins'}]
      test2 = [{one: 'eins'}]
      result = extend 'MODE CLONE', test1, test2
      expect(result[0], "test-1").to.not.equal test1[0]
      expect(result[1], "test-2").to.not.equal test2[0]

  describe "array replace mode", ->

    it "should replace array elements", ->
      test1 = [{one: 'eins'}]
      test2 = [{one: 'two'}]
      result = extend 'MODE ARRAY_REPLACE', test1, test2
      expect(result[0], "test-1").to.not.equal test1[0]
      expect(result[0], "test-2").to.equal test2[0]

  describe "array overwrite mode", ->

    it "should overwrite array elements", ->
      test1 = [{one: 'eins'}]
      test2 = [{one: 'two'}]
      result = extend 'MODE ARRAY_OVERWRITE', test1, test2
      expect(result[0], "test-1").to.equal test1[0]
      expect(result[0], "test-2").to.deep.equal test1[0]
      expect(result[0], "test-3").to.deep.equal test2[0]
      expect(result[0].one, "test-4").to.equal test2[0].one
