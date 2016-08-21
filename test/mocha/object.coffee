chai = require 'chai'
expect = chai.expect
### eslint-env node, mocha ###

describe "Object", ->

  {object} = require '../../src/index'

  describe "isEmpty", ->

    it "should detect empty objects", ->
      expect(object.isEmpty(null), "null").to.equal true
      expect(object.isEmpty(undefined), "undefined").to.equal true
      expect(object.isEmpty([]), "array").to.equal true
      expect(object.isEmpty({}), "object").to.equal true

    it "should detect not empty objects", ->
      expect(object.isEmpty([4]), "array").to.equal false
      expect(object.isEmpty({a: 1}), "object").to.equal false

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
      expect(object.path(test, ['', 'object', 'numbers', 'one'])).to.equal 1

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
      expect(object.pathSearch(test, '*')).to.deep.equal test
      expect(object.pathSearch(test, '**')).to.deep.equal test

    it "should access subelement", ->
      expect(object.pathSearch(test, '/string')).to.deep.equal test.string
      expect(object.pathSearch(test, 'string')).to.deep.equal test.string
      expect(object.pathSearch(test, ['string'])).to.deep.equal test.string

    it "should access list", ->
      expect(object.pathSearch(test, '/object/numbers/one')).to.equal 1
      expect(object.pathSearch(test, 'object/numbers')).to.deep.equal test.object.numbers
      expect(object.pathSearch(test, ['', 'object', 'numbers', 'one'])).to.equal 1

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
      expect(object.pathSearch(test, '*/numbers')).to.deep.equal {one: 1, two: 2}
      expect(object.pathSearch(test, 'object/*/two')).to.equal 2

    it "should find multilevel asterisk in path", ->
      expect(object.pathSearch(test, '**/numbers')).to.deep.equal test.object.numbers
      expect(object.pathSearch(test, '**/one')).to.deep.equal 1

    it "should find element using regular expressions", ->
      expect(object.pathSearch(test, '**/st.*')).to.deep.equal test.string
      expect(object.pathSearch(test, '**/o[ne]*')).to.deep.equal 1

    it "should fail to find something", ->
      expect(object.pathSearch(test, 'notthere')).to.not.exist
      expect(object.pathSearch(test, 'notthere/*')).to.not.exist
      expect(object.pathSearch(test, '**/notthere')).to.not.exist

  describe "filter", ->

    test =
      one: 1
      two: 2
      three: 3
      four: 4

    it "should not exclude anything", ->
      expect(object.filter(test, (-> true ))).to.deep.equal test

    it "should exclude everything", ->
      expect(object.filter(test, (-> false ))).to.deep.equal {}

    it "should exclude some values", ->
      expect(object.filter(test, ( (v) -> v < 3 ))).to.deep.equal
        one: 1
        two: 2

  describe "lcKeys", ->

    test =
      One: 1
      TWO:
        three: 3
        fouR: 4

    it "should make keys lowercase", ->
      expect object.lcKeys test
      .to.deep.equal
        one: 1
        two:
          three: 3
          four: 4

  describe "isCyclic", ->

    test1 =
      one: [1]
    test2 =
      one: [1]
    test2.two = test2.one
    test3 =
      sub: test2

    it "should detect cylic", ->
      expect(object.isCyclic test1).to.equal false
      expect(object.isCyclic test2).to.equal true
      expect(object.isCyclic test3).to.equal true

  describe "getCyclic", ->

    test1 =
      one: [1]
    test2 =
      one: [1]
    test2.two = test2.one
    test3 =
      sub: test2

    it "should detect cylic", ->
      expect(object.getCyclic(test1), 'test 1').to.deep.equal []
      expect(object.getCyclic(test2), 'test 2').to.deep.equal [test2.one]
      expect(object.getCyclic(test3), 'test 3').to.deep.equal [test2.one]
