Version changes
=================================================

The following list gives a short overview about what is changed between
individual versions:

Version 1.1.3 (2016-04-01)
-------------------------------------------------
- Upgraded builder and chalk.
- Add extend method which replaces arrays.

Version 1.1.2 (2016-03-22)
-------------------------------------------------
- Fix array.unique to also work on object lists.

Version 1.1.1 (2016-03-21)
-------------------------------------------------
- Upgraded builder.
- Allow array delimiter to be given as regexp string.

Version 1.1.0 (2016-03-16)
-------------------------------------------------
- Upgraded builder and chalk.
- Added tests and fixed bug in object lcKeys.
- Extend examples.
- Add method to make object keys lowercase.
- Add possibility to easily convert text to list or table.
- Fixed general link in README.

Version 1.0.0 (2016-02-26)
-------------------------------------------------
- Upgraded builder to newest version.
- Added sortBy method for arrays.

Version 0.3.15 (2016-02-04)
-------------------------------------------------
- updated ignore files.
- Updated development tools.
- Added missing validator.
- Updated development tools.
- Updated development tools.
- Updated development tools.
- Updated development tools.
- Updated development tools.
- Fixed style of test cases.
- Fixed lint warnings in code.
- Updated meta data of package and travis build versions.

Version 0.3.14 (2015-12-18)
-------------------------------------------------
- Fixed bug which breaks in a continuing line to early.

Version 0.3.13 (2015-12-08)
-------------------------------------------------
- Use complete changed algorithm for wordwrapping because the old was cutting words with over length.

Version 0.3.12 (2015-12-08)
-------------------------------------------------
- Fix use of uninitialized variable in wordwrap.

Version 0.3.11 (2015-12-02)
-------------------------------------------------
- Add test case for string.cpad().
- Add string.cpad() for center text using padding.

Version 0.3.10 (2015-11-16)
-------------------------------------------------
- Allow all tests to run.
- Fix shorten to not cut on first space and add test case.

Version 0.3.9 (2015-11-11)
-------------------------------------------------
- Added possibility to shorten text word aware.
- Fixed wordwrap to not keep whitespace at line start or end.

Version 0.3.8 (2015-10-30)
-------------------------------------------------
- Added information for version 0.3.7
- Fix version info.

Version 0.3.7 (2015-10-30)
-------------------------------------------------
- Fix version info.
- Added information for version 0.3.7
- Added wordwrap function.
- Make debug more specific.

Version 0.3.6 (2015-08-06)
-------------------------------------------------
- Added support for object.filter() like array.filter().

Version 0.3.5 (2015-07-17)
-------------------------------------------------
- Added possibility to remove object keys by setting them to null.

Version 0.3.4 (2015-06-30)
-------------------------------------------------
- Fixed handling of empty strings.

Version 0.3.3 (2015-06-30)
-------------------------------------------------
- Code style optimization.
- Added string.trim function.

Version 0.3.2 (2015-06-26)
-------------------------------------------------
- Fixed wrong named method object.isempty to object.isEmpty.

Version 0.3.1 (2015-06-25)
-------------------------------------------------
- Enabled all tests.
- Added pathSearch method.
- Added object.path to jump into object.
- Updated insstall documentation.

Version 0.3.0 (2015-06-25)
-------------------------------------------------
- Updated changelog.
- Added extendArrayConcat method and fixed extend with containing arrays.
- Added information for version 0.2.4
- Check for objects in extend by name to detect objects created in sandbox.
- Made badge links npm compatible in documentation.
- Extended test coverage.
- Allow parseSeconds and parseMSeconds to also work without spaces as separator.
- Added parseMSeconds description.
- Completed tests for number classes.
- Updated coerage tests.
- Add coveralls.
- Fixed changelog.

Version 0.2.3 (2015-06-15)
-------------------------------------------------
- Upgraded dependent modules.
- Fix bug in extend when 'toString' is used as key.

Version 0.2.2 (2015-05-26)
-------------------------------------------------
- Added new method to documentation.
- Added array.unique() method.
- Merge branch 'master' of https://github.com/alinex/node-util
- Update documentation structure.
- Converted code examples into coffee-script.
- Format documentation in coffeescript.

Version 0.2.1 (2015-03-03)
-------------------------------------------------
- update to use builder

Version 0.2.0 (2015-03-03)
-------------------------------------------------
- Upgraded travis check list.
- Added object.isempty() method.

Version 0.1.11 (2014-11-21)
-------------------------------------------------
- Renamed internal variable for conformance only.
- Fixed bug in object extend/clone which makes null values into {}.

Version 0.1.10 (2014-10-21)
-------------------------------------------------
- Fixed bug in extending objects containing 0 or ''.

Version 0.1.9 (2014-10-08)
-------------------------------------------------
- Updated npmignore to not ignore too much.
- Fixed changelog.
- Automatic string conversion in pad methods.
- Added test routines for lpad and rpad.

Version 0.1.8 (2014-09-30)
-------------------------------------------------
- Added 'lpad' and 'rpad' methods for strings.
- Upgrade alinex-make.

Version 0.1.7 (2014-09-17)
-------------------------------------------------
- Fixed calls to new make tool.
- Update to alinex-make 0.3 for development.
- Added string.contains method.
- Add description for npm.

Version 0.1.6 (2014-08-07)
-------------------------------------------------
- Allow number signs in seconds and mseconds parse.
- Added ucFirst and lcFirst methods for strings.

Version 0.1.5 (2014-07-31)
-------------------------------------------------
- Fixed again.

Version 0.1.4 (2014-07-31)
-------------------------------------------------
- Fixed parseSeconds and parseMSeconds to not fail on objects but to give NaN.

Version 0.1.3 (2014-07-31)
-------------------------------------------------
- Adds number.parseMSeconds.

Version 0.1.2 (2014-07-31)
-------------------------------------------------
- Add number.getSeconds to parse human readable interval.
- Finished strict parseInt method.
- Added new bug buggy filterInt method.

Version 0.1.1 (2014-07-29)
-------------------------------------------------
- Added number utilities.
- Updated documentation.
- Added link to alinex module in documentation.
- Remove coveralls as direct dependency.

Version 0.1.0 (2014-05-24)
-------------------------------------------------
- Test on compiled code.
- Added array.last() method and fixed small bug in array extending/cloning.
- Added repeat method for strings.
- Finished string.ends() and string.starts() functions.
- Added string method container.

Version 0.0.1 (2014-05-21)
-------------------------------------------------
- Finished clone() and expand() methods.
- Added clone tests.
- Added test methods for extend function.

