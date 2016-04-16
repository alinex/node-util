chai = require 'chai'
expect = chai.expect
### eslint-env node, mocha ###

{extend} = require '../../src/index'

describe.only "Extend", ->

  it "should keep object if only one", ->
    test = null
    result = extend test
    expect(result, "deep check").to.deep.equal test
    expect(result, "reference").to.equal test
    test = {eins: 1}
    result = extend test
    expect(result, "deep check").to.deep.equal test
    expect(result, "reference").to.equal test

  it "should keep object if empty ones added", ->
    test = null
    result = extend test, null, undefined
    expect(result, "deep check").to.deep.equal test
    expect(result, "reference").to.equal test
    test = {eins: 1}
    result = extend test, null, undefined
    expect(result, "deep check").to.deep.equal test
    expect(result, "reference").to.equal test


  it "should keep object if empty ones before", ->
    test = null
    result = extend null, undefined, test
    expect(result, "deep check 1").to.deep.equal test
    expect(result, "reference 1").to.equal test
    test = {eins: 1}
    result = extend null, undefined, test
    expect(result, "deep check 2").to.deep.equal test
    expect(result, "reference 2").to.equal test


  it "should clone object", ->
    test = {eins: 1}
    result = object.extend null, test
    expect(result, "deep check").to.deep.equal test
    expect(result, "reference").to.not.equal test

  it "should let object untouched for empty extenders", ->
    test = {eins: 1}
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
    test = {eins: 1}
    result = object.extend {}, test
    expect(result, "deep check").to.deep.equal test
    expect(result, "is cloned").to.not.equal test

  it "should add integer attribute", ->
    test = {eins: 1}
    result = object.extend test, {drei: 3}
    expect(result, "equal check").to.equal test
    expect(result, "contains key eins").to.include.keys 'eins'
    expect(result, "contains key drei").to.include.keys 'drei'

  it "should overwrite entry", ->
    test = {eins: 1}
    result = object.extend test, {eins: 'eins'}
    expect(result, "is changed").to.equal test
    expect(result, "contains key eins").to.include.keys 'eins'
    expect(result.eins, "value changed").to.equal 'eins'

  it "should add multiple extenders", ->
    test = {eins: 1}
    result = object.extend test, {zwei: 2}, {eins: 'eins'}, {drei: 3}
    expect(result, "is changed").to.equal test
    expect(result, "contains key eins").to.include.keys 'eins'
    expect(result, "contains key zwei").to.include.keys 'zwei'
    expect(result, "contains key drei").to.include.keys 'drei'
    expect(result.eins, "value changed").to.equal 'eins'

  it "should extend empty object with 0", ->
    result = object.extend null, 0
    expect(result, "value changed").to.equal 0

  it "should make clone array elements", ->
    test1 = [{one: 'eins'}]
    test2 = [{one: 'eins'}]
    result = object.extend test1, test2
    expect(result[0], "test-1").to.equal test1[0]
    expect(result[1], "test-2").to.not.equal test2[0]

  it "should work with toString as name", ->
    test = {toString: 'eins'}
    result = object.extend {}, test
    expect(result, "test-1").to.deep.equal test
    test = {toString: {}}
    result = object.extend {}, test
    expect(result, "test-2").to.deep.equal test

  it "should remove key if set to null", ->
    base = {eins: 1}
    test = {eins: null, zwei: 2}
    result = object.extend base, test
    expect(result, "deep check").to.deep.equal {zwei: 2}

describe "extendArrayConcat", ->

  it "should clone object", ->
    test = {eins: 1}
    result = object.extendArrayConcat null, test
    expect(result, "deep check").to.deep.equal test
    expect(result, "reference").to.not.equal test

  it "should let object untouched for empty extenders", ->
    test = {eins: 1}
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
    test = {eins: 1}
    result = object.extendArrayConcat {}, test
    expect(result, "deep check").to.deep.equal test
    expect(result, "is cloned").to.not.equal test

  it "should add integer attribute", ->
    test = {eins: 1}
    result = object.extendArrayConcat test, {drei: 3}
    expect(result, "equal check").to.equal test
    expect(result, "contains key eins").to.include.keys 'eins'
    expect(result, "contains key drei").to.include.keys 'drei'

  it "should overwrite entry", ->
    test = {eins: 1}
    result = object.extendArrayConcat test, {eins: 'eins'}
    expect(result, "is changed").to.equal test
    expect(result, "contains key eins").to.include.keys 'eins'
    expect(result.eins, "value changed").to.equal 'eins'

  it "should add multiple extenders", ->
    test = {eins: 1}
    result = object.extendArrayConcat test, {zwei: 2}, {eins: 'eins'}, {drei: 3}
    expect(result, "is changed").to.equal test
    expect(result, "contains key eins").to.include.keys 'eins'
    expect(result, "contains key zwei").to.include.keys 'zwei'
    expect(result, "contains key drei").to.include.keys 'drei'
    expect(result.eins, "value changed").to.equal 'eins'

  it "should extend empty object with 0", ->
    result = object.extendArrayConcat null, 0
    expect(result, "value changed").to.equal 0

  it "should make references to array elements", ->
    test1 = [{one: 'eins'}]
    test2 = [{one: 'eins'}]
    result = object.extendArrayConcat test1, test2
    expect(result[0], "test-1").to.equal test1[0]
    expect(result[1], "test-2").to.equal test2[0]

  it "should work with toString as name", ->
    test = {toString: 'eins'}
    result = object.extendArrayConcat {}, test
    expect(result, "test-1").to.deep.equal test
    test = {toString: {}}
    result = object.extendArrayConcat {}, test
    expect(result, "test-2").to.deep.equal test

  it "should remove key if set to null", ->
    base = {eins: 1}
    test = {eins: null, zwei: 2}
    result = object.extendArrayConcat base, test
    expect(result, "deep check").to.deep.equal {zwei: 2}

describe "extendArrayReplace", ->

  it "should clone object", ->
    test = {eins: 1}
    result = object.extendArrayReplace null, test
    expect(result, "deep check").to.deep.equal test
    expect(result, "reference").to.not.equal test

  it "should let object untouched for empty extenders", ->
    test = {eins: 1}
    orig = object.extendArrayReplace null, test
    object.extendArrayReplace test, {}
    expect(test, "deep check").to.deep.equal orig
    expect(test, "reference").to.not.equal orig
    test = object.extendArrayReplace test, {}
    expect(test, "deep check").to.deep.equal orig
    expect(test, "reference").to.not.equal orig
    test = object.extendArrayReplace test
    expect(test, "deep check").to.deep.equal orig
    expect(test, "reference").to.not.equal orig

  it "should clone into empty object", ->
    test = {eins: 1}
    result = object.extendArrayReplace {}, test
    expect(result, "deep check").to.deep.equal test
    expect(result, "is cloned").to.not.equal test

  it "should add integer attribute", ->
    test = {eins: 1}
    result = object.extendArrayReplace test, {drei: 3}
    expect(result, "equal check").to.equal test
    expect(result, "contains key eins").to.include.keys 'eins'
    expect(result, "contains key drei").to.include.keys 'drei'

  it "should overwrite entry", ->
    test = {eins: 1}
    result = object.extendArrayReplace test, {eins: 'eins'}
    expect(result, "is changed").to.equal test
    expect(result, "contains key eins").to.include.keys 'eins'
    expect(result.eins, "value changed").to.equal 'eins'

  it "should add multiple extenders", ->
    test = {eins: 1}
    result = object.extendArrayReplace test, {zwei: 2}, {eins: 'eins'}, {drei: 3}
    expect(result, "is changed").to.equal test
    expect(result, "contains key eins").to.include.keys 'eins'
    expect(result, "contains key zwei").to.include.keys 'zwei'
    expect(result, "contains key drei").to.include.keys 'drei'
    expect(result.eins, "value changed").to.equal 'eins'

  it "should extend empty object with 0", ->
    result = object.extendArrayReplace null, 0
    expect(result, "value changed").to.equal 0

  it "should make replace array elements", ->
    test1 = [1, 2, 3]
    test2 = [4, 5, 6]
    result = object.extendArrayReplace test1, test2
    expect(result, "test").to.deep.equal test2

  it "should work with toString as name", ->
    test = {toString: 'eins'}
    result = object.extendArrayReplace {}, test
    expect(result, "test-1").to.deep.equal test
    test = {toString: {}}
    result = object.extendArrayReplace {}, test
    expect(result, "test-2").to.deep.equal test

  it "should remove key if set to null", ->
    base = {eins: 1}
    test = {eins: null, zwei: 2}
    result = object.extendArrayReplace base, test
    expect(result, "deep check").to.deep.equal {zwei: 2}
