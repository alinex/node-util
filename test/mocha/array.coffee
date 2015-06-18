chai = require 'chai'
expect = chai.expect

describe "Array", ->

  {array} = require '../../src/index'

  describe "last", ->

    it "should get element", ->
      test = [ 1,2,3,4,5 ]
      expect array.last(test)
      , "get last"
      .to.be.equal 5

    it "should get element with offset", ->
      test = [ 1,2,3,4,5 ]
      expect array.last(test, 1)
      , "get last"
      .to.be.equal 4

  describe "unique", ->

    it "should remove duplicates", ->
      test = [ 1,2,2,3,4,1,5 ]
      expect array.unique(test)
      , "unique"
      .to.be.deep.equal [ 1,2,3,4,5 ]

  describe "prototype", ->

    it "should get element", ->
      array.addToPrototype()
      test = [ 1,2,3,4,5 ]
      expect test.last()
      , "get last"
      .to.be.equal 5

    it "should remove duplicates", ->
      test = [ 1,2,2,3,4,1,5 ]
      expect test.unique()
      , "unique"
      .to.be.deep.equal [ 1,2,3,4,5 ]
