## Local development

For brevity, we'll assume you use a Mac for development.

* Install [homebrew](http://brew.sh) to manage binary packages
    * `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
* Install [rbenv](https://github.com/sstephenson/rbenv) and [ruby-build](https://github.com/sstephenson/ruby-build/wiki) for Ruby version mgmt
    * `brew install rbenv ruby-build`
* Install the Ruby version specified in `.ruby-version`
    * `rbenv install`
* Install the [Bundler](http://bundler.io) gem to manage Ruby libraries ("gems")
    * `gem install bundler`
    * `bundle install`
* Run the dev server:
    * `middleman start`

