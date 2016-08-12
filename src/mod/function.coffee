###
Function Wrapper
==================================================
The following functions are used to wrap functions to give them more functionality.
You will get a resulting function which can be called any time.

In all of the following methods you may give an optional context to use as first
parameter. So to call it from class do so like:

``` coffee
class = Test
  init: util.function.once this, (cb) ->
    # method...
    cb null, @status
```

That allows your function to access class members and methods. Keep in mind to use
`=>` if you use sub functions.

If you use it in `module.exports` then do it as follows:

``` coffee
module.exports =
  anyMethod: (cb) ->
  # and so on

module.exports.init = util.function.once module.exports, (cb) ->
  # method...
  @anyMethod cb
```

Like you see above you have to declare this method separately so that the `util.function.once`
method can access the now already defined module.exports object.
###


# Includes
# -------------------------------------------------
debug = require('debug')('util:function')
chalk = require 'chalk'
# internal helper
util = require 'util'


# Setup
# -------------------------------------------------
functionId = 0 # internal counter for names


# Exported Methods
# -------------------------------------------------

###
Run method only once but return the same result to all calls:

``` coffee
fn = util.function.once (cb) ->
  time = process.hrtime()
  setTimeout ->
    cb null, time[1]
  , 1000
```

Use this to make some initializations which only have to run once but neither
function may start because it is not done:

``` coffee
async.parallel [ fn, fn ], (err, results) ->
  # same as with `once.atime` it will come here exactly after the
  # first call finished because the second one will get the
  # result the same time
  # results here will be the same integer, twice
  fn (err, result) ->
    # and this call will return imediately with the previous result
```

@param {Object} context within the function will run
@param {Function} func to be called
@return the second and later calls will return with the same result
@throw {Error} Argument func is not a function!
###
module.exports.once = (context, func) ->
  unless func
    func = context
    context = undefined
  # check parameters
  unless typeof func is 'function'
    throw new Error "Argument func is not a function!"
  # flags
  started = false # if the function has already started
  done = false    # if the function has already ended
  listeners = []  # callbacks waiting
  results = []    # the results stored for further calls
  func.__id ?= ++functionId
  debug "wait ##{func.__id}: created for #{chalk.grey func}"
  if context
    debug "wait ##{func.__id}: using specific context"
  # return wait function
  ->
    # get callback parameter
    args = [].slice.call arguments
    cb = args.pop() ? {}
    # return if already done
    if done
      debug "wait ##{func.__id}: called again -> send result"
      return cb.apply context, results
    # add to listeners
    listeners.push cb
    if started
      debug "wait ##{func.__id}: called again while running"
      return
    debug "wait ##{func.__id}: called"
    # add the wait callback
    started = true
    args.push ->
      debug "wait ##{func.__id}: done"
      # store results
      done = true
      results = [].slice.call arguments
      # call all listeners
      for cb in listeners
        debug "wait ##{func.__id}: inform listener"
        cb.apply context, results
      listeners = null
    # run real function
    func.apply context, args

###
Throw an error if it is called a second time:

``` coffee
fn = util.function.onceThrow (a, b, cb) -> cb null, a + b
```

If you call this method multiple times it will throw an exception:

``` coffee
fn 2, 3, (err, x) ->
  # x will now be 5
  fn 2, 9, (err, x) ->
    # will neither get there because an exception is thrown above
```

@param {Object} context within the function will run
@param {Function} func to be called
@return result on first call only
@throw {Error} Argument func is not a function!
@throw {Error} This function should only be called once.
###
module.exports.onceThrow = (context, func) ->
  unless func
    func = context
    context = undefined
  # check parameters
  unless typeof func is 'function'
    throw new Error "Argument func is not a function!"
  # flags
  called = false
  func.__id ?= ++functionId
  debug "throw ##{func.__id}: created for #{chalk.grey func}"
  if context
    debug "throw ##{func.__id}: using specific context"
  # return throw function
  ->
    # throw error after first call
    debug "throw ##{func.__id}: called"
    if called
      debug "throw ##{func.__id}: called again issuing an error"
      throw new Error "This function should only be called once."
    # run real function
    called = true
    func.apply context, arguments

###
With the skip method only the first call works all other will return an Error.

A function may be wrapped with the skip method. And it will only be called once
for ever.

``` coffee
fn = util.function.onceSkip (a, b) -> a + b
```

And now you can call the function as normal but on the second call it will
return imediately without running the code:

``` coffee
x = fn 2, 3
# x = 5
x = fn 2, 3
# x = <Error>
```

You may use this helper in case of initialization (wait) there a specific
method have to run once before any other call can succeed. Or then events
are involved and an error event will trigger the callback and the end event will
do the same.

@param {Object} context within the function will run
@param {Function} func to be called
@return {Mixed|Error} the reuslt or an `Èrror` if called multiple times
@throw {Error} Argument func is not a function!
###
module.exports.onceSkip = (context, func) ->
  unless func
    func = context
    context = undefined
  # check parameters
  unless typeof func is 'function'
    throw new Error "Argument func is not a function!"
  # flags
  called = false
  func.__id ?= ++functionId
  debug "skip ##{func.__id}: created for #{chalk.grey func}"
  if context
    debug "skip ##{func.__id}: using specific context"
  # return skip function
  ->
    # get callback parameter
    cb = arguments[arguments.length-1]
    # throw error after first call
    if called
      debug "skip ##{func.__id}: skipped because already called"
      err = new Error "This function should only be called once."
      return cb err if typeof cb is 'function'
      return err
    debug "skip ##{func.__id}: called"
    # run real function
    called = true
    func.apply context, arguments

###
Only run it once at a time, queue following requests and send them the result
of the next run. All calls get the same result, but then the process is already
started it will list the following calls for the next round. This assures that
their result is from the newest data set because you may changed something
while the first run was already working.

``` coffee
fn = util.function.onceTime (cb) ->
  time = process.hrtime()
  setTimeout ->
    cb null, time[1]
  , 1000
```

And now you may call it multiple times but it will not run more than once
simultaneously. But all simultaneous calls will get the same result.

``` coffee
async.parallel [ fn, fn ], (err, results) ->
  # will come here exactly after the first call finished (because the
  # second will do so the same time)
  # results here will be the same integer, twice
```

@param {Object} context within the function will run
@param {Function} func to be called
@throw {Error} Argument func is not a function!
###
module.exports.onceTime = (context, func) ->
  unless func
    func = context
    context = undefined
  # check parameters
  unless typeof func is 'function'
    throw new Error "Argument func is not a function!"
  # flags
  started = false # if the function has already started
  listeners = []  # callbacks waiting
  next = [] # list for the next round
  func.__id ?= ++functionId
  debug "time ##{func.__id}: created for #{chalk.grey func}"
  if typeof context is 'object' and Object.keys(context).length
    debug "time ##{func.__id}: using specific context #{chalk.grey util.inspect context}"
  # return time function
  nfunc = ->
    # get callback parameter
    args = [].slice.call arguments
    cb = args.pop() ? {}
    idargs = util.inspect(args[0..]).replace /\n\s*/g, ' '
    # add to listeners
    if started
      debug "time ##{func.__id}: #{chalk.grey idargs} called but waiting"
      next.push [idargs, args, cb]
      return
    else
      debug "time ##{func.__id}: #{chalk.grey idargs} called"
      listeners.push cb
    started = true
    # add the time callback
    args.push ->
      debug "time ##{func.__id}: #{chalk.grey idargs} done with
      result
      #{chalk.grey util.inspect arguments}"
      # start sending back and reopening method
      started = false
      work = [].slice.call listeners
      listeners = []
      # call all listeners
      for cb in work
        debug "time ##{func.__id}: #{chalk.grey idargs} inform listener"
        cb.apply context, arguments
      # rerun if more to do
      if next.length
        [id, args, cb] = next.shift()
        debug "time ##{func.__id}: #{chalk.grey id} restart"
        args.push cb
        nfunc.apply this, args
    # run real function
    func.apply context, args
  nfunc
