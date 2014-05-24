chai = require 'chai'
expect = chai.expect

describe "String", ->

  {string} = require '../../lib/index'

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
