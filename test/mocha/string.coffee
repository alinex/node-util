chai = require 'chai'
expect = chai.expect

describe "String", ->

  {string} = require '../../src/index'

  describe "starts", ->

    it "should match string start", ->
      test = 'abcdefg'
      expect string.starts(test, 'ab')
      , "find match"
      .to.be.true
      expect string.starts(test, 'bc')
      , "find match"
      .to.be.false

    it "should match with offset", ->
      test = 'abcdefg'
      expect string.starts(test, 'ab', 1)
      , "find match"
      .to.be.false
      expect string.starts(test, 'bc', 1)
      , "find match"
      .to.be.true

  describe "ends", ->

    it "should match string end", ->
      test = 'abcdefg'
      expect string.ends(test, 'fg')
      , "find match"
      .to.be.true
      expect string.ends(test, 'ef')
      , "find match"
      .to.be.false

    it "should match with offset", ->
      test = 'abcdefg'
      expect string.ends(test, 'fg', 1)
      , "find match"
      .to.be.false
      expect string.ends(test, 'ef', 1)
      , "find match"
      .to.be.true

  describe "repeat", ->

    it "should repeat n times", ->
      test = 'ab'
      expect string.repeat(test, 1)
      , "1 repeat"
      .to.be.equal 'ab'
      expect string.repeat(test, 3)
      , "3 repeats"
      .to.be.equal 'ababab'
      expect string.repeat(test, 0)
      , "0 repeats"
      .to.be.equal ''
      expect string.repeat(test)
      , "no repeat"
      .to.be.equal ''

  describe "lpad", ->

    it "should left pad string", ->
      test = 'ab'
      expect string.lpad(test, 5)
      , "normal left pad"
      .to.be.equal '   ab'

    it "should left pad string with character", ->
      test = 'ab'
      expect string.lpad(test, 5, 'x')
      , "normal left pad with x"
      .to.be.equal 'xxxab'

    it "should not pad if not neccessary", ->
      test = 'ab'
      expect string.lpad(test, 2)
      , "left pad not necessary"
      .to.be.equal 'ab'
      expect string.lpad(test, 1)
      , "left pad not necessary"
      .to.be.equal 'ab'

  describe "rpad", ->

    it "should right pad string", ->
      test = 'ab'
      expect string.rpad(test, 5)
      , "normal right pad"
      .to.be.equal 'ab   '

    it "should right pad string with character", ->
      test = 'ab'
      expect string.rpad(test, 5, 'x')
      , "normal right pad with x"
      .to.be.equal 'abxxx'

    it "should not pad if not neccessary", ->
      test = 'ab'
      expect string.rpad(test, 2)
      , "right pad not necessary"
      .to.be.equal 'ab'
      expect string.rpad(test, 1)
      , "right pad not necessary"
      .to.be.equal 'ab'

  describe "trim", ->

    it "should trim string (default)", ->
      expect string.trim(' ab\n')
      , "trim both sides"
      .to.be.equal 'ab'
      expect string.trim(' ab\n-')
      , "trim only left side"
      .to.be.equal 'ab\n-'
      expect string.trim('- ab\n')
      , "trim only right side"
      .to.be.equal '- ab'
      expect string.trim('ab')
      , "trim nothing"
      .to.be.equal 'ab'

    it "should trim specific char", ->
      test = '/ab//'
      expect string.trim(test, '/')
      , "trim slashes"
      .to.be.equal 'ab'

  describe "ucFirst", ->

    it "should make first letter upper case", ->
      expect string.ucFirst 'hello'
      , "use hello"
      .to.be.equal 'Hello'
      expect string.ucFirst 'Hello'
      , "use Hello"
      .to.be.equal 'Hello'

  describe "lcFirst", ->

    it "should make first letter lower case", ->
      string.addToPrototype()
      expect string.lcFirst 'hello'
      , "use hello"
      .to.be.equal 'hello'
      expect string.lcFirst 'Hello'
      , "use Hello"
      .to.be.equal 'hello'

  describe "prototype", ->

    it "should match string start", ->
      string.addToPrototype()
      test = 'abcdefg'
      expect test.starts('ab')
      , "find match"
      .to.be.true
      expect test.starts('bc')
      , "find match"
      .to.be.false

    it "should match string end", ->
      string.addToPrototype()
      test = 'abcdefg'
      expect test.ends('fg')
      , "find match"
      .to.be.true
      expect test.ends('ef')
      , "find match"
      .to.be.false

    it "should repeat n times", ->
      string.addToPrototype()
      test = 'ab'
      expect test.repeat(3)
      , "3 repeats"
      .to.be.equal 'ababab'

    it "should make first letter upper case", ->
      string.addToPrototype()
      expect 'hello'.ucFirst()
      , "use hello"
      .to.be.equal 'Hello'
      expect 'Hello'.ucFirst()
      , "use Hello"
      .to.be.equal 'Hello'

    it "should make first letter lower case", ->
      string.addToPrototype()
      expect 'hello'.lcFirst()
      , "use hello"
      .to.be.equal 'hello'
      expect 'Hello'.lcFirst()
      , "use Hello"
      .to.be.equal 'hello'

    it "should contain substring", ->
      string.addToPrototype()
      expect 'hello'.contains 'll'
      , "use hello"
      .to.be.true

    it "should not contain substring", ->
      string.addToPrototype()
      expect 'card'.contains 'll'
      , "use card"
      .to.be.false

    it "should left pad string", ->
      string.addToPrototype()
      expect 'ab'.lpad(5)
      , "normal left pad"
      .to.be.equal '   ab'

    it "should right pad string", ->
      string.addToPrototype()
      expect 'ab'.rpad(5)
      , "normal right pad"
      .to.be.equal 'ab   '
