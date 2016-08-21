chai = require 'chai'
expect = chai.expect
### eslint-env node, mocha ###
async = require 'async'

util = require '../../src/index'

describe "once", ->

  describe "default", ->

    it "should call function with callback", (done) ->
      fn = util.function.once (cb) ->
        time = process.hrtime()
        setTimeout ->
          cb null, time[1]
        , 1000
      fn (err, x) ->
        expect(x, 'result').to.exist
        done()

    it "should run once with two parallel calls", (done) ->
      fn = util.function.once (cb) ->
        time = process.hrtime()
        setTimeout ->
          cb null, time[1]
        , 1000
      async.parallel [ fn, fn ], (err, results) ->
        expect(err, 'error').to.not.exist
        expect(results[0], 'same result').to.equal results[1]
        done()

    it "should return immediately on the second call", (done) ->
      fn = util.function.once (cb) ->
        time = process.hrtime()
        setTimeout ->
          cb null, time[1]
        , 1000
      async.series [ fn, fn ], (err, results) ->
        expect(err, 'error').to.not.exist
        expect(results[0], 'different result').to.equal results[1]
        done()

    it "should run in context", (done) ->
      context = {one: 1}
      fn = util.function.onceTime context, (cb) ->
        setTimeout =>
          cb null, @one
        , 1000
      fn (err, x) ->
        expect(x, 'result').to.equal 1
        done()

  describe "onceThrow", ->

    it "should call function with return", ->
      fn = util.function.onceThrow (a, b) -> a + b
      x = fn 2, 3
      expect(x, 'result').to.equal 5

    it "should call function with callback", ->
      fn = util.function.onceThrow (a, b, cb) -> cb a + b
      fn 2, 3, (x) ->
        expect(x, 'result').to.equal 5

    it "should throw error on second call", ->
      fn = util.function.onceThrow (a, b) -> a + b
      x = fn 2, 3
      expect( ->
        x = fn 3, 4
      , 'second call'
      ).to.throw Error
      expect(x).to.exist

    it "should run in context", ->
      context = {base: 2}
      fn = util.function.onceThrow context, (b) -> @base + b
      x = fn 3
      expect(x, 'result').to.equal 5

  describe "onceSkip", ->

    it "should call function with return", ->
      fn = util.function.onceSkip (a, b) -> a + b
      x = fn 2, 3
      expect(x, 'result').to.equal 5

    it "should call function with callback", ->
      fn = util.function.onceSkip (a, b, cb) -> cb a + b
      fn 2, 3, (x) ->
        expect(x, 'result').to.equal 5

    it "should return error on second call", ->
      fn = util.function.onceSkip (a, b) -> a + b
      x = fn 2, 3
      expect(x, 'result').to.equal 5
      x = fn 2, 3
      expect(x, 'second call').to.be.instanceof Error

    it "should callback error on second call", ->
      fn = util.function.onceSkip (a, b, cb) -> cb a + b
      fn 2, 3, (x) ->
        expect(x, 'result').to.equal 5
        fn 2, 3, (x) ->
          expect(x, 'second call').to.be.instanceof Error

    it "should run in context", ->
      context = {base: 2}
      fn = util.function.onceSkip context, (b) -> @base + b
      x = fn 3
      expect(x, 'result').to.equal 5

  describe "onceTime", ->

    it "should call function with callback", (done) ->
      fn = util.function.onceTime (cb) ->
        time = process.hrtime()
        setTimeout ->
          cb null, time[1]
        , 1000
      fn (err, x) ->
        expect(x, 'result').to.exist
        done()

    it "should run once with parallel calls", (done) ->
      @timeout 10000
      fn = util.function.onceTime (cb) ->
        time = new Date().getTime()
        setTimeout ->
          cb null, time
        , 1000
      async.parallel [ fn, fn, fn ], (err, results) ->
        expect(err, 'error').to.not.exist
        expect(results[0], 'first lower').to.be.below results[1]
        expect(results[1], 'others same result').to.be.below results[2]
        done()

    it "should run twice with two serial calls", (done) ->
      @timeout 5000
      fn = util.function.onceTime (cb) ->
        time = new Date().getTime()
        setTimeout ->
          cb null, time
        , 1000
      async.series [ fn, fn ], (err, results) ->
        expect(err, 'error').to.not.exist
        expect(results[0], 'different result').to.not.equal results[1]
        done()

    it "should run in context", (done) ->
      context = {one: 1}
      fn = util.function.onceTime context, (cb) ->
        setTimeout =>
          cb null, @one
        , 1000
      fn (err, x) ->
        expect(x, 'result').to.equal 1
        done()

  describe "no function", ->

    it "should fail for once", (done) ->
      expect( -> util.function.once 'test' ).to.throw Error
      done()

    it "should fail for onceThrow", (done) ->
      expect( -> util.function.onceThrow 'test' ).to.throw Error
      done()

    it "should fail for onceSkip", (done) ->
      expect( -> util.function.onceSkip 'test' ).to.throw Error
      done()

    it "should fail for onceTime", (done) ->
      expect( -> util.function.onceTime 'test' ).to.throw Error
      done()
