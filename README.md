# Steak [![Build Status](https://secure.travis-ci.org/cavalle/steak.png)](http://travis-ci.org/cavalle/steak) [![Dependency Status](https://gemnasium.com/cavalle/steak.png)](https://gemnasium.com/cavalle/steak)

The delicious combination of RSpec and Capybara for Acceptance BDD

![Steak!!](http://dl.dropbox.com/u/645329/steak_small.jpg "Steak!!")

## What is Steak?

Steak is a minimal extension of RSpec-Rails that adds several conveniences to do acceptance testing of Rails applications using Capybara. It's an alternative to Cucumber in plain Ruby. This is how an acceptance spec looks like in Steak:

    feature 'Main page' do

      background do
        create_user :login => 'jdoe'
      end

      scenario 'should show existing quotes' do
        create_quote :text => 'The language of friendship is not words, but meanings',
                     :author => 'Henry David Thoreau'

        login_as 'jdoe'
        visit '/'

        within('.quote') do
          page.should have_content('The language of friendship is not words, but meanings')
          page.should have_content('Henry David Thoreau')
        end
      end
      
    end

No givens, whens or thens. No steps, no english, just Ruby. The delicious combination of RSpec and Capybara. That's Steak!

## Why Steak?

If, after all, this is just RSpec + Capybara, why does Steak even exist? Do I really need it?

Basically Steak exists for three reasons:

1. **Making a point**. First of all, Steak proposes that using RSpec and Capybara for acceptance testing is a sensible alternative to Cucumber. It also sets a name to refer to that approach.
1. **Adding convenience**. As a gem, Steak aims to make the experience as convenient as possible. It provides Rails integration testing support and several generators and rake tasks so that setting up a new project or creating and running specs are quick and seamless tasks. A natural extension of RSpec-Rails.
1. **Building a community**. No development approach or ruby gem is really valuable without an active community behind it. The mailing list, the IRC channel, the wiki or the twitter account are useful tools to build a community of users that help each other by sharing knowledge, resources and best practices.

## Getting Started

_NOTE: The current version of Steak (2.0) assumes that you're testing a Rails 3 application, with RSpec 2 and Capybara. For Rails 2, RSpec 1 or Webrat you should use [Steak 1](https://github.com/cavalle/steak/tree/steak-1) (or consider upgrading to non-obsolete technologies ;P)_

It's super-easy to get you started. Just add the gem to your `Gemfile`…

    group :test, :development do
      gem 'steak'
      # ...

…and then install the gem and run the generator:

    $ bundle
    $ rails g steak:install

You're now set up! Note that Steak is the only dependency you really need, you can safely remove any reference to `capybara`, `rspec-rails` or `rspec` from your `Gemfile`, they will be included by Steak. Also note that, unless previously executed, Steak will run the RSpec generator so you don't need to invoke it.

Take a look now at the default directory structure you've got under `spec/acceptance`. It will help you organize the helpers and configurations for your acceptance specs.


## Creating and running specs

You can create your specs by hand, however you may prefer to use the generator:

    $ rails g steak:spec my_first_feature

To run your acceptance specs you just do like with any other spec…

    $ bundle exec rspec spec/acceptance/my_first_feature_spec.rb

…or using rake:

    $ rake spec:acceptance

## Resources

* [Source code](http://github.com/cavalle/steak) – Lurking and forking
* [Issues](http://github.com/cavalle/steak/issues) – Bugs and feature requests
* [Google Group](http://groups.google.com/group/steakrb) & [IRC channel](irc://irc.freenode.net/jenkinsci) – Help and discussion
* [Twitter](http://twitter.com/steakrb) – Announcements and mentions
* [Wiki](https://github.com/cavalle/steak/wiki) – Tutorials, docs and other resources

## Credits

Steak was created by [Luismi Cavallé](http://lmcavalle.com) and improved thanks to the love from:

* Álvaro Bautista
* Felipe Talavera
* Paco Guzmán
* Jeff Kreeftmeijer
* Jaime Iniesta
* Emili Parreño
* Andreas Wolff
* Wincent Colaiuta
* Falk Pauser
* Francesc Esplugas
* Raúl Murciano
* Enable Interactive
* Vojto Rinik
* Fred Wu
* Sergio Espeja
* Joao Carlos

Copyright © 2009 - 2011 Luismi Cavallé, released under the MIT license
