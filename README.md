# ModelsInPlace

[![Build Status](https://www.travis-ci.com/jacoblockard99/models_in_place.svg?branch=master)](https://www.travis-ci.com/jacoblockard99/models_in_place)
[![Inline docs](http://inch-ci.org/github/jacoblockard99/models_in_place.svg?branch=master)](http://inch-ci.org/github/jacoblockard99/models_in_place)
[![Maintainability](https://api.codeclimate.com/v1/badges/e94de688acfc28dd569e/maintainability)](https://codeclimate.com/github/jacoblockard99/models_in_place/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/e94de688acfc28dd569e/test_coverage)](https://codeclimate.com/github/jacoblockard99/models_in_place/test_coverage)

[`edit_in_place`](https://github.com/jacoblockard99/edit_in_place) is a gem that allows for the creation of intuitive editable content. It is extremely flexible and powerful. But the vast majority of users will be using `edit_in_place` in a very similar way, using models to store and manipulate editable data. `models_in_place` provides a layer of convenience atop `edit_in_place`, making it easier (and more fun!) to use when you are working in a model-like system. You'll likely want to use `models_in_place` if you use models—whether ActiveRecord ones or not—to store data and then use `edit_in_place` fields to allow for the edition of attributes on those models.

## Links

  - [API Docs](https://rubydoc.info/github/jacoblockard99/models_in_place)
  - [CHANGELOG.md](CHANGELOG.md)
  - [Releases](https://github.com/jacoblockard99/models_in_place/releases)

## Installation

`models_in_place` is a Ruby gem. If you use Bundler, you may install it by adding it to your `Gemfile`, like so:

```ruby
gem 'models_in_place'
```

And then execute:
```bash
$ bundle install
```

Or you may install it manually with:
```bash
$ gem install models_in_place
```

## Setup

A little setup is required to integrate `models_in_place` with `edit_in_place`. First, you'll need to create an instance of `ModelsInPlace::Builder` that wraps your base `EditInPlace::Builder`. You'll probably do something like this, depending on where you instantiate your builders:

```ruby
class SomeController < ApplicationController
  def index
    base = EditInPlace::Builder.new
    @builder = ModelsInPlace::Builder.new(base)
  end
end
```

Now in your views, you may use `@builder` just like you would an `EditInPlace::Builder`, but you may also use all the `models_in_place` extension methods.

Next, you'll need to inject the `models_in_place` middlewares into your configuration. `models_in_place` heavily relies on middlewares to provide its functionality. There are four middleware classes that you need to define in your `Configuration#defined_middlewares` array:
  - `ModelsInPlace::Middlewares::OptionsInjector`—This middleawre ensures that the last field input is an option hash, appending an empty hash if necessary.
  - `ModelsInPlace::Middlewares:SignatureEnforcer`—This middleware ensures that all fields inputs are as `models_in_place` expects them. This can help prevent obscure errors down the line.
  - `ModelsInPlace::Middlewares::OptionsInsert`—This middleware allows options to be dynamically appended to a field. This is used internally to provide the functionality for option scopes. You may also use it directly is desired.
  - `ModelsInPlace::Middlewares::ModelAdaptere`—This middleware converts any model instances into `ModelsInPlace::ModelAdapter` instances (more on that later).

You should define the middlewares in roughly the order listed. The most important thing is that `OptionsInjector` **must** come before `SignatureEnforcer`, and `OptionsInsert` and `ModelAdapter` **should** come after the `SignatureEnforcer`. Depending on your middleware setup, you'll likely use something akin to this:

```ruby
EditInPlace.configure do |c|
  c.defined_middlewares = [
    ModelsInPlace::Middleware::OptionsInjector,
    ModelsInPlace::Middleware::SignatureEnforcer,
    ModelsInPlace::Middleware::OptionsInsert,
    ModelsInPlace::Middleware::ModelAdapter
  ]
end
```

Be sure that your custom middlewares are ordered correctly around those of `models_in_place`! For example, if you have a middleware that relies upon accessing the options hash, be sure to define it after the `OptionsInjector` and likely after the `OptionsInsert`.

Finally, you need to add these middlewares. If you will be using `models_in_place` across your entire application, you may add them globally, like so:

```ruby
EditInPlace.configure do |c|
  # ...
  
  c.field_options.middlewares += [
    ModelsInPlace::Middleware::OptionsInjector.new,
    ModelsInPlace::Middleware::SignatureEnforcer.new,
    ModelsInPlace::Middleware::OptionsInsert.new,
    ModelsInPlace::Middleware::ModelAdapter.new
  ]
end
```

You can add this anywhere—`edit_in_place` will take care of ordering them correctly according to the definitions above. You could also add this to a specific builder by using `EditInPlace::Builder#configure` or `EditInPlace::Builder#config`.

That's it! You're ready to begin using `models_in_place`! See below for usage instructions.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'models_in_place'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install models_in_place
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
