chai = require 'chai'
expect = chai.expect
### eslint-env node, mocha ###

describe "Array", ->

  {array} = require '../../src/index'

  describe "last", ->

    it "should get element", ->
      test = [1, 2, 3, 4, 5]
      expect array.last(test)
      , "get last"
      .to.be.equal 5

    it "should get element with offset", ->
      test = [1, 2, 3, 4, 5]
      expect array.last(test, 1)
      , "get last"
      .to.be.equal 4

  describe "unique", ->

    it "should remove duplicates", ->
      test = [1, 2, 2, 3, 4, 1, 5]
      expect array.unique(test)
      , "unique"
      .to.be.deep.equal [1, 2, 3, 4, 5]

    it "should remove duplicate objects", ->
      test = [{a: 1}, {b: 1}, {a: 1}, {c: 1}]
      expect array.unique(test)
      , "unique"
      .to.be.deep.equal [{a: 1}, {b: 1}, {c: 1}]

  describe "sortBy", ->

    it "should sort objects by column", ->
      test = [
        {first: 'Johann Sebastion', last: 'Bach'}
        {first: 'Wolfgang Amadeus', last: 'Mozart'}
        {first: 'Michael', last: 'Haydn'}
        {first: 'Joseph', last: 'Haydn'}
        {first: 'Richard', last: 'Wagner'}
        {first: 'Antonio', last: 'Vivaldi'}
        {first: 'Franz', last: 'Schubert'}
      ]
      expect array.sortBy(test, 'last')
      , "sortBy last"
      .to.be.deep.equal [
        {first: 'Johann Sebastion', last: 'Bach'}
        {first: 'Michael', last: 'Haydn'}
        {first: 'Joseph', last: 'Haydn'}
        {first: 'Wolfgang Amadeus', last: 'Mozart'}
        {first: 'Franz', last: 'Schubert'}
        {first: 'Antonio', last: 'Vivaldi'}
        {first: 'Richard', last: 'Wagner'}
      ]
      expect array.sortBy(test, '-last')
      , "sortBy last reverse"
      .to.be.deep.equal [
        {first: 'Richard', last: 'Wagner'}
        {first: 'Antonio', last: 'Vivaldi'}
        {first: 'Franz', last: 'Schubert'}
        {first: 'Wolfgang Amadeus', last: 'Mozart'}
        {first: 'Michael', last: 'Haydn'}
        {first: 'Joseph', last: 'Haydn'}
        {first: 'Johann Sebastion', last: 'Bach'}
      ]

    it "should sort objects by multiple columns", ->
      test = [
        {first: 'Johann Sebastion', last: 'Bach'}
        {first: 'Wolfgang Amadeus', last: 'Mozart'}
        {first: 'Michael', last: 'Haydn'}
        {first: 'Joseph', last: 'Haydn'}
        {first: 'Richard', last: 'Wagner'}
        {first: 'Antonio', last: 'Vivaldi'}
        {first: 'Franz', last: 'Schubert'}
      ]
      expect array.sortBy(test, 'last', 'first')
      , "sortBy last, first"
      .to.be.deep.equal [
        {first: 'Johann Sebastion', last: 'Bach'}
        {first: 'Joseph', last: 'Haydn'}
        {first: 'Michael', last: 'Haydn'}
        {first: 'Wolfgang Amadeus', last: 'Mozart'}
        {first: 'Franz', last: 'Schubert'}
        {first: 'Antonio', last: 'Vivaldi'}
        {first: 'Richard', last: 'Wagner'}
      ]
      expect array.sortBy(test, '-last', '-first')
      , "sortBy last, first reverse"
      .to.be.deep.equal [
        {first: 'Richard', last: 'Wagner'}
        {first: 'Antonio', last: 'Vivaldi'}
        {first: 'Franz', last: 'Schubert'}
        {first: 'Wolfgang Amadeus', last: 'Mozart'}
        {first: 'Michael', last: 'Haydn'}
        {first: 'Joseph', last: 'Haydn'}
        {first: 'Johann Sebastion', last: 'Bach'}
      ]
