# SpreeProductFiles

[![Build Status](https://travis-ci.org/stefansenk/spree_product_files.svg?branch=master) ](https://travis-ci.org/stefansenk/spree_product_files)

Allows files to be uploaded to a product. E.g. PDF data files.

## Installation

1. Add this extension to your Gemfile with this line:
  ```ruby
  gem 'spree_product_files', github: 'stefansenk/spree_product_files'
  ```

2. Install the gem using Bundler:
  ```ruby
  bundle install
  ```

3. Copy & run migrations
  ```ruby
  bundle exec rails g spree_product_files:install
  ```

4. Restart your server

  If your server was running, restart it so that it can find the assets properly.

## Testing

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle
bundle exec rake
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_product_files/factories'
```


## Contributing

If you'd like to contribute, please take a look at the
[instructions](CONTRIBUTING.md) for installing dependencies and crafting a good
pull request.

Copyright (c) 2021 [stefansenk], released under the New BSD License
