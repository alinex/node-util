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
