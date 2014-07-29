chai = require 'chai'
expect = chai.expect

describe "Number", ->

  {number} = require '../../lib/index'

  describe "isInteger", ->

    it "should succeed on real integers", ->
      expect number.isInteger(6)
      , "use 6"
      .to.be.true
      expect number.isInteger(0)
      , "use 0"
      .to.be.true
      expect number.isInteger(-12)
      , "use -12"
      .to.be.true
      expect number.isInteger(1200000)
      , "use 1200000"
      .to.be.true
      expect number.isInteger(12.000)
      , "use 12.000"
      .to.be.true

    it "should fail on string integers", ->
      expect number.isInteger('6')
      , "use '6'"
      .to.be.false
      expect number.isInteger('0')
      , "use '0'"
      .to.be.false
      expect number.isInteger('-12')
      , "use '-12'"
      .to.be.false
      expect number.isInteger('1200000')
      , "use '1200000'"
      .to.be.false
      expect number.isInteger('12.000')
      , "use '12.000'"
      .to.be.false

    it "should fail on real floats", ->
      expect number.isInteger(1.2)
      , "use 1.2"
      .to.be.false

    it "should fail on undefined values", ->
      expect number.isInteger()
      , "use undefined"
      .to.be.false

    it "should fail on strings", ->
      expect number.isInteger('hello')
      , "use 'hello'"
      .to.be.false

    it "should fail on objects", ->
      expect number.isInteger({})
      , "use {}"
      .to.be.false

    it "should fail on arrays", ->
      expect number.isInteger([])
      , "use []"
      .to.be.false
