chai = require 'chai'
expect = chai.expect
### eslint-env node, mocha ###

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

  describe "lpad", ->

    it "should left pad string", ->
      test = 'ab'
      expect string.lpad(test, 5)
      , "normal left pad"
      .to.be.equal '   ab'

    it "should left pad string with character", ->
      test = 'ab'
      expect string.lpad(test, 5, 'x')
      , "normal left pad with x"
      .to.be.equal 'xxxab'

    it "should not pad if not neccessary", ->
      test = 'ab'
      expect string.lpad(test, 2)
      , "left pad not necessary"
      .to.be.equal 'ab'
      expect string.lpad(test, 1)
      , "left pad not necessary"
      .to.be.equal 'ab'

    it "should pad integer using toString()", ->
      test = new Number 10
      expect string.lpad(test, 5)
      , "normal left pad"
      .to.be.equal '   10'

  describe "rpad", ->

    it "should right pad string", ->
      test = 'ab'
      expect string.rpad(test, 5)
      , "normal right pad"
      .to.be.equal 'ab   '

    it "should right pad string with character", ->
      test = 'ab'
      expect string.rpad(test, 5, 'x')
      , "normal right pad with x"
      .to.be.equal 'abxxx'

    it "should not pad if not neccessary", ->
      test = 'ab'
      expect string.rpad(test, 2)
      , "right pad not necessary"
      .to.be.equal 'ab'
      expect string.rpad(test, 1)
      , "right pad not necessary"
      .to.be.equal 'ab'

    it "should pad integer using toString()", ->
      test = new Number 10
      expect string.rpad(test, 5)
      , "normal left pad"
      .to.be.equal '10   '

  describe "cpad", ->

    it "should center pad string", ->
      test = 'ab'
      expect string.cpad(test, 5)
      , "normal ĉenter pad"
      .to.be.equal ' ab  '

    it "should center pad string with character", ->
      test = 'ab'
      expect string.cpad(test, 5, 'x')
      , "normal center pad with x"
      .to.be.equal 'xabxx'

    it "should not pad if not neccessary", ->
      test = 'ab'
      expect string.cpad(test, 2)
      , "center pad not necessary"
      .to.be.equal 'ab'
      expect string.cpad(test, 1)
      , "center pad not necessary"
      .to.be.equal 'ab'

    it "should pad integer using toString()", ->
      test = new Number 10
      expect string.cpad(test, 5)
      , "normal left pad"
      .to.be.equal ' 10  '

  describe "trim", ->

    it "should trim string (default)", ->
      expect string.trim(' ab\n')
      , "trim both sides"
      .to.be.equal 'ab'
      expect string.trim(' ab\n-')
      , "trim only left side"
      .to.be.equal 'ab\n-'
      expect string.trim('- ab\n')
      , "trim only right side"
      .to.be.equal '- ab'
      expect string.trim('ab')
      , "trim nothing"
      .to.be.equal 'ab'

    it "should trim specific char", ->
      test = '/ab//'
      expect string.trim(test, '/')
      , "trim slashes"
      .to.be.equal 'ab'

  describe "ucFirst", ->

    it "should make first letter upper case", ->
      expect string.ucFirst 'hello'
      , "use hello"
      .to.be.equal 'Hello'
      expect string.ucFirst 'Hello'
      , "use Hello"
      .to.be.equal 'Hello'

  describe "lcFirst", ->

    it "should make first letter lower case", ->
      expect string.lcFirst 'hello'
      , "use hello"
      .to.be.equal 'hello'
      expect string.lcFirst 'Hello'
      , "use Hello"
      .to.be.equal 'hello'

  describe "contains", ->

    it "should check if phrase is present in text", ->
      expect string.contains 'hello', 'h'
      , "use hello -> h"
      .to.be.true
      expect string.contains 'hello', 'll'
      , "use hello -> h"
      .to.be.true
      expect string.contains 'hello', 'LL'
      , "use hello -> h"
      .to.be.false

  describe "wordwrap", ->

    it "should wrap with defaults", ->
      expect string.wordwrap "A high CPU usage means that the server may not start
      another task immediately.
      If the load is also very high the system is overloaded, check if any application
      goes evil."
      .to.be.equal """
      A high CPU usage means that the server may not start another task immediately.
      If the load is also very high the system is overloaded, check if any application
      goes evil.
      """
      expect string.wordwrap """
      All necessary parts are on the same machine, so that you only have to bring this machine to work. Backups of the data are made on vs10152.

      Keep in mind that the machine is in the test net and you have to use a valid VPN connection for accessing.
      """, 78
      .to.be.equal """
      All necessary parts are on the same machine, so that you only have to bring
      this machine to work. Backups of the data are made on vs10152.

      Keep in mind that the machine is in the test net and you have to use a valid
      VPN connection for accessing.
      """

    it "should not wrap in long words", ->
      expect string.wordwrap "![google](https://www.google.de/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png)", null, 0
      .to.be.equal "![google](https://www.google.de/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png)"

    it "should wrap after long words", ->
      expect string.wordwrap "![google](https://www.google.de/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png) is great"
      .to.be.equal "![google](https://www.google.de/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png)\nis great"

    it "should not wrap short text", ->
      expect string.wordwrap "This is\nashort text.", 78
      .to.be.equal "This is\nashort text."

  describe "shorten", ->

    it "should cut long text", ->
      expect string.shorten "A high CPU usage means that the server may not start
      another task immediately.
      If the load is also very high the system is overloaded, check if any application
      goes evil.", 60
      .to.be.equal "A high CPU usage means that the server may not start..."

    it "should keep short text the same", ->
      expect string.shorten 'Hello World!', 60
      .to.be.equal 'Hello World!'

  describe "toList", ->

    test = 'one,two,three\n1,2,3\n4,5,6'

    it "should convert to simple list (default separator)", ->
      expect string.toList test
      .to.be.deep.equal [
        'one,two,three'
        '1,2,3'
        '4,5,6'
      ]

    it "should convert to simple list", ->
      expect string.toList test, /\n/
      .to.be.deep.equal [
        'one,two,three'
        '1,2,3'
        '4,5,6'
      ]

    it "should convert to table", ->
      expect string.toList test, /\n/, /,/
      .to.be.deep.equal [
        ['one', 'two', 'three']
        ['1', '2', '3']
        ['4', '5', '6']
      ]

  describe "toRegExp", ->

    it "should convert text", ->
      expect string.toRegExp '/a/'
      .to.be.instanceOf RegExp

    it "should keep other text", ->
      expect string.toRegExp 'Hello World!'
      .to.be.equal 'Hello World!'

    it "should return object if no string", ->
      expect string.toRegExp Number 5
      .to.be.equal 5
