chai = require 'chai'
expect = chai.expect
### eslint-env node, mocha ###

{clone} = require '../../src/index'

describe "Clone", ->

  it "should copy null", ->
    test = null
    result = clone test
    expect(result, "deep check").to.deep.equal test
    expect(result, "reference").to.equal test

  it "should clone object", ->
    test = {eins: 1}
    result = clone test
    expect(result, "deep check").to.deep.equal test
    expect(result, "reference").to.not.equal test

  it "should clone string", ->
    test = "eins"
    result = clone test
    expect(result, "deep check").to.deep.equal test

  it "should clone array", ->
    test = [1, 2, 3]
    result = clone test
    expect(result, "deep check").to.deep.equal test
    expect(result, "reference").to.not.equal test

  it "should clone array of arrays", ->
    test = [[1, [2], 3]]
    result = clone test
    expect(result, "deep check").to.deep.equal test
    expect(result, "reference").to.not.equal test
    expect(result[0], "reference.list").to.not.equal test[0]
    expect(result[0][1], "reference.list").to.not.equal test[0][1]

  it "should clone object of arrays", ->
    test = {a: [1, [2], 3]}
    result = clone test
    expect(result, "deep check").to.deep.equal test
    expect(result, "reference").to.not.equal test
    expect(result.a, "reference.object").to.not.equal test.a
    expect(result.a[1], "reference.list").to.not.equal test.a[1]

  it "should clone array of objects", ->
    test = [{name: 'Anzahl', anzahl: '1734'}]
    result = clone test
    expect(result, "deep check").to.deep.equal test
    test[0].anzahl = 9999
    expect(result, "reference").to.not.equal test
    expect(result[0], "reference.object").to.not.equal test[0]
    expect(result[0].anzahl, "reference.list").to.not.equal test[0].anzahl

  it "should clone date", ->
    test = new Date()
    result = clone test
    expect(result, "deep check").to.deep.equal test
    expect(result, "reference").to.not.equal test

  it "should clone regexp", ->
    test = /ab/gim
    result = clone test
    expect(result, "deep check").to.deep.equal test
    expect(result, "reference").to.not.equal test

  it "should copy instance reference", ->
    test = new Error "Test error"
    result = clone test
    expect(result, "deep check").to.deep.equal test
    expect(result, "reference").to.equal test

  it "should clone complex structure", ->
    test =
      eins: 1
      zwei: [2]
      drei: 'drei'
      vier:
        array: [1, 2, 3]
        error: new Error 'Test error'
        regexp: /ab/
        date: new Date()
    result = clone test
    expect(result, "deep check").to.deep.equal test
    expect(result, "reference").to.not.equal test

  it "should clone circular references", ->
    test =
      eins: 1
      zwei: [2]
    test.drei = test.zwei
    result = clone test
    expect(result, "deep check").to.deep.equal test
    expect(result, "reference").to.not.equal test
    result.drei[0] = 3
    expect(result.drei, "reference kept").to.equal result.zwei

  it "should clone defined depth", ->
    test =
      one:
        value: 1
        two:
          value: 1
          three:
            value : 1
    result = clone test, 3
    expect(result, "deep check").to.deep.equal test
    expect(result, "reference").to.not.equal test
    test.one.value = 1
    test.one.two.value = 2
    test.one.two.three.value = 3
    expect(result.one.two, "reference").to.not.equal test.one.two
    expect(result.one.two.three, "reference kept").to.equal test.one.two.three
