# Steak Release History #

## Version 1.1.0 / 2011-01-15 ##

[full changelog](https://github.com/cavalle/steak/compare/v1.0.1...v1.1.0)

### Enhancements ###

* If rspec-rails is present, a Steak spec now inherits from RequestExampleGroup which already takes care of including Webrat or Capybara. That means that `acceptance_helper.rb` no longer needs to include or initialize them (only change the default configuration if necessary)
* Ensure that rake works in environments without rspec gem installed

### Bugfixes ###

* Prevents the generator from emptying spec/acceptance when running 'rails destroy steak:spec'.


## Version 1.0.1 / 2010-12-26 ##

[full changelog](https://github.com/cavalle/steak/compare/v1.0.0...v1.0.1)

### Bugfixes ###

* Fix `be_` and `have_` matchers not working with rspec 1.3

## Version 1.0.0 / 2010-10-22 ##

First stable version of Steak. [Announcement](http://groups.google.com/group/steakrb/browse_thread/thread/b90c86d0b7464a56)