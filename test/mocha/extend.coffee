chai = require 'chai'
expect = chai.expect
### eslint-env node, mocha ###

{extend} = require '../../src/index'

describe "Extend", ->

  describe "default mode", ->

    it "should get null if nothing given", ->
      result = extend()
      expect(result, "exist").to.not.exist

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

    it "should replace on extending class instance", ->
      base = new Error '1'
      test = new Error '2'
      result = extend base, test
      expect(result, "deep check").to.equal test

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

  describe "array modes", ->

    it "should concat array elements completely", ->
      test1 = {a: [1, 2, 3], b: ['1', '2', '3'], c: [1, 2, 3]}
      test2 = {a: [4, 5, 6], b: ['4', '5', '6'], c: [4, 5, 6]}
      result = extend test1, test2
      expect(result, "test-1").to.deep.equal
        a: [1, 2, 3, 4, 5, 6]
        b: ['1', '2', '3', '4', '5', '6']
        c: [1, 2, 3, 4, 5, 6]

    it "should replace array elements completely", ->
      test1 = {a: [1, 2, 3], b: [1, 2, 3], c: [1, 2, 3]}
      test2 = {a: [4, 5, 6], b: [4, 5, 6], c: [4, 5, 6]}
      result = extend 'MODE ARRAY_REPLACE', test1, test2
      expect(result, "test-1").to.deep.equal test2
      expect(result.a, "test-2").to.equal test2.a

    it "should replace array elements in one level", ->
      test1 = {a: [1, 2, 3], b: [1, 2, 3], c: [1, 2, 3]}
      test2 = {a: [4, 5, 6], b: ['MODE ARRAY_REPLACE', 4, 5, 6], c: [4, 5, 6]}
      result = extend test1, test2
      expect(result, "test-1").to.deep.equal
        a: [ 1, 2, 3, 4, 5, 6 ]
        b: [ 4, 5, 6 ]
        c: [ 1, 2, 3, 4, 5, 6 ]
      expect(result.b, "test-2").to.equal test2.b

    it "should overwrite array elements completely", ->
      test1 = {a: [1, 2, 3], b: [1, 2, 3], c: [1, 2, 3]}
      test2 = {a: [4, 5], b: [4, 5, 6], c: [null, 5, 6]}
      result = extend 'MODE ARRAY_OVERWRITE', test1, test2
      expect(result, "test-1").to.deep.equal {a: [ 4, 5, 3 ], b: [ 4, 5, 6 ], c: [ 1, 5, 6 ]}
      expect(result.b, "test-2").to.not.equal test2.b
      expect(result.b, "test-3").to.deep.equal test2.b

    it "should overwrite array elements completely", ->
      test1 = {a: [1, 2, 3], b: [1, 2, 3], c: [1, 2, 3]}
      test2 = {a: [4, 5], b: [4, 5, 6], c: ['MODE ARRAY_OVERWRITE', null, 5, 6]}
      result = extend test1, test2
      expect(result, "test-1").to.deep.equal
        a: [ 1, 2, 3, 4, 5 ]
        b: [ 1, 2, 3, 4, 5, 6 ]
        c: [ 1, 5, 6 ]

  describe "object modes", ->

    it "should replace object elements completely", ->
      test1 = {test: {a: [1, 2, 3], b: [1, 2, 3], c: [1, 2, 3]}}
      test2 = {test: {a: [4, 5, 6], b: [4, 5, 6], d: [4, 5, 6]}}
      result = extend 'MODE OBJECT_REPLACE', test1, test2
      expect(result, "test-1").to.deep.equal
        test: {a: [ 4, 5, 6 ], b: [ 4, 5, 6 ], d: [ 4, 5, 6 ]}
      expect(result.test.d, "test-2").to.equal test2.test.d

    it "should replace object in one level", ->
      test1 = {test: {a: [1, 2, 3], b: [1, 2, 3], c: [1, 2, 3]}, test2: [1, 2, 3]}
      test2 = {test: {OBJECT_REPLACE: true, a: [4, 5, 6], b: [4, 5, 6], d: [4, 5, 6]}}
      result = extend test1, test2
      expect(result, "test-1").to.deep.equal
        test: {a: [ 4, 5, 6 ], b: [ 4, 5, 6 ], d: [ 4, 5, 6 ]}
        test2: [1, 2, 3]
      expect(result.test.d, "test-2").to.equal test2.test.d
      expect(result.test2, "test-2").to.deep.equal test1.test2
