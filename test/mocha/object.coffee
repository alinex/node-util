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

    it "should make clone array elements", ->
      test1 = [{ one: 'eins' }]
      test2 = [{ one: 'eins' }]
      result = object.extend test1, test2
      expect(result[0], "test-1").to.equal test1[0]
      expect(result[1], "test-2").to.not.equal test2[0]

    it "should work with toString as name", ->
      test = { toString: 'eins' }
      result = object.extend {}, test
      expect(result, "test-1").to.deep.equal test
      test = { toString: {} }
      result = object.extend {}, test
      expect(result, "test-2").to.deep.equal test

    it "should remove key if set to null", ->
      base = { eins: 1 }
      test = { eins: null, zwei: 2 }
      result = object.extend base, test
      expect(result, "deep check").to.deep.equal { zwei: 2 }

  describe "extendArrayConcat", ->

    it "should clone object", ->
      test = { eins: 1 }
      result = object.extendArrayConcat null, test
      expect(result, "deep check").to.deep.equal test
      expect(result, "reference").to.not.equal test

    it "should let object untouched for empty extenders", ->
      test = { eins: 1 }
      orig = object.extendArrayConcat null, test
      object.extendArrayConcat test, {}
      expect(test, "deep check").to.deep.equal orig
      expect(test, "reference").to.not.equal orig
      test = object.extendArrayConcat test, {}
      expect(test, "deep check").to.deep.equal orig
      expect(test, "reference").to.not.equal orig
      test = object.extendArrayConcat test
      expect(test, "deep check").to.deep.equal orig
      expect(test, "reference").to.not.equal orig

    it "should clone into empty object", ->
      test = { eins: 1 }
      result = object.extendArrayConcat {}, test
      expect(result, "deep check").to.deep.equal test
      expect(result, "is cloned").to.not.equal test

    it "should add integer attribute", ->
      test = { eins: 1 }
      result = object.extendArrayConcat test, { drei: 3 }
      expect(result, "equal check").to.equal test
      expect(result, "contains key eins").to.include.keys 'eins'
      expect(result, "contains key drei").to.include.keys 'drei'

    it "should overwrite entry", ->
      test = { eins: 1 }
      result = object.extendArrayConcat test, { eins: 'eins' }
      expect(result, "is changed").to.equal test
      expect(result, "contains key eins").to.include.keys 'eins'
      expect(result.eins, "value changed").to.equal 'eins'

    it "should add multiple extenders", ->
      test = { eins: 1 }
      result = object.extendArrayConcat test, { zwei: 2 }, { eins: 'eins' }, { drei: 3 }
      expect(result, "is changed").to.equal test
      expect(result, "contains key eins").to.include.keys 'eins'
      expect(result, "contains key zwei").to.include.keys 'zwei'
      expect(result, "contains key drei").to.include.keys 'drei'
      expect(result.eins, "value changed").to.equal 'eins'

    it "should extend empty object with 0", ->
      result = object.extendArrayConcat null, 0
      expect(result, "value changed").to.equal 0

    it "should make references to array elements", ->
      test1 = [{ one: 'eins' }]
      test2 = [{ one: 'eins' }]
      result = object.extendArrayConcat test1, test2
      expect(result[0], "test-1").to.equal test1[0]
      expect(result[1], "test-2").to.equal test2[0]

    it "should work with toString as name", ->
      test = { toString: 'eins' }
      result = object.extendArrayConcat {}, test
      expect(result, "test-1").to.deep.equal test
      test = { toString: {} }
      result = object.extendArrayConcat {}, test
      expect(result, "test-2").to.deep.equal test

    it "should remove key if set to null", ->
      base = { eins: 1 }
      test = { eins: null, zwei: 2 }
      result = object.extendArrayConcat base, test
      expect(result, "deep check").to.deep.equal { zwei: 2 }

  describe "isEmpty", ->

    it "should detect empty objects", ->
      expect(object.isEmpty(null), "null").to.equal true
      expect(object.isEmpty(undefined), "undefined").to.equal true
      expect(object.isEmpty([]), "array").to.equal true
      expect(object.isEmpty({}), "object").to.equal true

    it "should detect not empty objects", ->
      expect(object.isEmpty([4]), "array").to.equal false
      expect(object.isEmpty({a:1}), "object").to.equal false

  describe "path", ->

    test =
      string: 'test'
      object:
        numbers:
          one: 1
          two: 2
      list: [
        one: 1
      ,
        two: 2
      ]

    it "should access root", ->
      expect(object.path(test, '')).to.deep.equal test
      expect(object.path(test, '/')).to.deep.equal test
      expect(object.path(test, [])).to.deep.equal test

    it "should access subelement", ->
      expect(object.path(test, '/string')).to.deep.equal test.string
      expect(object.path(test, 'string')).to.deep.equal test.string
      expect(object.path(test, ['string'])).to.deep.equal test.string

    it "should access list", ->
      expect(object.path(test, '/object/numbers/one')).to.equal 1
      expect(object.path(test, 'object/numbers')).to.deep.equal test.object.numbers
      expect(object.path(test, ['','object','numbers','one'])).to.equal 1

    it "should access object", ->
      expect(object.path(test, '/list/0/one')).to.equal 1
      expect(object.path(test, 'list/1')).to.deep.equal test.list[1]

    it "should allow special separator", ->
      expect(object.path(test, 'list.0.one', '.')).to.equal 1
      expect(object.path(test, 'object.numbers.two', '.')).to.equal 2

    it "should allow regexp separator", ->
      expect(object.path(test, 'list;0; one', /[;:]\s*/)).to.equal 1
      expect(object.path(test, 'object:numbers;two', /[;:]\s*/)).to.equal 2

  describe "pathSearch", ->

    test =
      string: 'test'
      object:
        numbers:
          one: 1
          two: 2
      list: [
        one: 11
      ,
        two: 12
      ]

    it "should access root", ->
      expect(object.pathSearch(test, '')).to.deep.equal test
      expect(object.pathSearch(test, '/')).to.deep.equal test
      expect(object.pathSearch(test, [])).to.deep.equal test

    it "should access subelement", ->
      expect(object.pathSearch(test, '/string')).to.deep.equal test.string
      expect(object.pathSearch(test, 'string')).to.deep.equal test.string
      expect(object.pathSearch(test, ['string'])).to.deep.equal test.string

    it "should access list", ->
      expect(object.pathSearch(test, '/object/numbers/one')).to.equal 1
      expect(object.pathSearch(test, 'object/numbers')).to.deep.equal test.object.numbers
      expect(object.pathSearch(test, ['','object','numbers','one'])).to.equal 1

    it "should access object", ->
      expect(object.pathSearch(test, '/list/0/one')).to.equal 11
      expect(object.pathSearch(test, 'list/1')).to.deep.equal test.list[1]

    it "should allow special separator", ->
      expect(object.pathSearch(test, 'list.0.one', '.')).to.equal 11
      expect(object.pathSearch(test, 'object.numbers.two', '.')).to.equal 2

    it "should allow regexp separator", ->
      expect(object.pathSearch(test, 'list;0; one', /[;:]\s*/)).to.equal 11
      expect(object.pathSearch(test, 'object:numbers;two', /[;:]\s*/)).to.equal 2

    it "should allow asterisk in path", ->
      expect(object.pathSearch(test, '*/numbers')).to.deep.equal { one: 1, two: 2 }
      expect(object.pathSearch(test, 'object/*/two')).to.equal 2

    it "should find multilevel asterisk in path", ->
      expect(object.pathSearch(test, '**/numbers')).to.deep.equal test.object.numbers
      expect(object.pathSearch(test, '**/one')).to.deep.equal 1

    it "should find element using regular expressions", ->
      expect(object.pathSearch(test, '**/st.*')).to.deep.equal test.string
      expect(object.pathSearch(test, '**/o[ne]*')).to.deep.equal 1

  describe "filter", ->

    test =
      one: 1
      two: 2
      three: 3
      four: 4

    it "should not exclude anything", ->
      expect(object.filter(test, ( (v, k) -> true ))).to.deep.equal test

    it "should exclude everything", ->
      expect(object.filter(test, ( (v, k) -> false ))).to.deep.equal {}

    it "should exclude some values", ->
      expect(object.filter(test, ( (v, k) -> v < 3 ))).to.deep.equal
        one: 1
        two: 2

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
