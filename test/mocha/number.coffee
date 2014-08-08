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

  describe "parseInt", ->

    it "should succeed on normal values", ->
      expect number.parseInt('421')
      .to.equal 421
      expect number.parseInt('-421')
      .to.equal -421
      expect number.parseInt('+421')
      .to.equal 421
      expect number.parseInt('0')
      .to.equal 0
      expect number.parseInt('Infinity')
      .to.equal Infinity

    it "should fail on other strings", ->
      expect number.parseInt('421hop')
      .to.deep.equal NaN
      expect number.parseInt('hop421')
      .to.deep.equal NaN
      expect number.parseInt('1.23')
      .to.deep.equal NaN
      expect number.parseInt('421e+0')
      .to.deep.equal NaN

  describe "parseSeconds", ->

    it "should read normal integers", ->
      expect number.parseSeconds(6)
      , "use 6"
      .to.equal 6

    it "should read human strings", ->
      expect number.parseSeconds('120s')
      , "use 120s"
      .to.equal 120
      expect number.parseSeconds('+120s')
      , "use +120s"
      .to.equal 120
      expect number.parseSeconds('5m')
      , "use 5m"
      .to.equal 300
      expect number.parseSeconds('2h')
      , "use 2h"
      .to.equal 7200

    it "should read combined strings", ->
      expect number.parseSeconds('2h 5m 100s')
      , "use 2h 5m 100s"
      .to.equal 7600

    it "should convert floats", ->
      expect number.parseSeconds('2.5h')
      , "use 2.5h"
      .to.equal 9000

    it "should be case insensitive", ->
      expect number.parseSeconds('2H')
      , "use 2H"
      .to.equal 7200

    it "should return NaN", ->
      expect number.parseSeconds('2h 5m 100smilies')
      , "use 2h 5m 100sekunden"
      .to.deep.equal NaN
      expect number.parseSeconds('2k')
      , "use 2k"
      .to.deep.equal NaN

  describe "parseMSeconds", ->

    it "should read normal integers", ->
      expect number.parseMSeconds(6)
      , "use 6"
      .to.equal 6

    it "should read human strings", ->
      expect number.parseMSeconds('120ms')
      , "use 120ms"
      .to.equal 120
      expect number.parseMSeconds('+120ms')
      , "use +120ms"
      .to.equal 120
      expect number.parseMSeconds('120s')
      , "use 120s"
      .to.equal 120000
      expect number.parseMSeconds('5m')
      , "use 5m"
      .to.equal 300000
      expect number.parseMSeconds('2h')
      , "use 2h"
      .to.equal 7200000

    it "should read combined strings", ->
      expect number.parseMSeconds('2h 5m 100s')
      , "use 2h 5m 100s"
      .to.equal 7600000

    it "should convert floats", ->
      expect number.parseMSeconds('2.5h')
      , "use 2.5h"
      .to.equal 9000000

    it "should be case insensitive", ->
      expect number.parseMSeconds('2H')
      , "use 2H"
      .to.equal 7200000

    it "should return NaN", ->
      expect number.parseMSeconds('2h 5m 100smilies')
      , "use 2h 5m 100sekunden"
      .to.deep.equal NaN
      expect number.parseMSeconds('2k')
      , "use 2k"
      .to.deep.equal NaN
