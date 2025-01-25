![Tests](https://github.com/Jeurei/rails-project-63/actions/workflows/lint.yml/badge.svg) [![Actions Status](https://github.com/Jeurei/rails-project-63/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Jeurei/rails-project-63/actions)

# FormGenerator

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/form_generator`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'form_generator'
```

And then execute:

    bundle install

Or install it yourself as:

    gem install form_generator

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/[USERNAME]/form_generator>.

## Usage example

```ruby
user = { name: 'John Doe', bio: 'Software Developer' }

form_html = FormGenerator.form_for(user, url: '/submit') do |f|
f.input :name
f.input :bio, as: :text
end.to_s

puts form_html

### Output

```

<form action="/submit" method="post">
  <input value="John Doe" />
  <textarea value="Software Developer"></textarea>
</form>
```

```

```
