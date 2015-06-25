Version changes
=================================================

The following list gives a short overview about what is changed between
individual versions:

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

