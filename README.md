![Tests](https://github.com/Jeurei/rails-project-63/actions/workflows/lint.yml/badge.svg) [![Actions Status](https://github.com/Jeurei/rails-project-63/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Jeurei/rails-project-63/actions)

# FormBuilder

FormBuilder is a Ruby gem that simplifies form creation in Ruby applications. It provides an easy-to-use API to generate HTML forms dynamically, reducing boilerplate code and improving maintainability.

## Installation

To install FormBuilder, add the following line to your application's Gemfile:

```ruby
gem 'form_generator'
```

Then, run:

```bash
bundle install
```

Alternatively, you can install the gem manually with:

```bash
gem install form_generator
```

## Usage

FormBuilder provides a simple DSL for building HTML forms. Here’s an example of how to use it:

```ruby
require 'form_generator'

user = { name: 'John Doe', bio: 'Software Developer' }

form_html = FormBuilder.form_for(user, url: '/submit') do |f|
f.input :name
f.input :bio, as: :text
end.to_s

puts form_html
```

## Output

```html
<form action="/submit" method="post">
  <input value="John Doe" />
  <textarea value="Software Developer"></textarea>
</form>
```

## Development

If you want to contribute or modify this gem, follow these steps:

Clone the repository:

```bash
git clone <https://github.com/Jeurei/form_generator.git>
cd form_generator
```

Install dependencies:

```bash
bin/setup
```

Use an interactive console to experiment with the gem:

```bash
bin/console
```

To install the gem on your local machine:

```bash
bundle exec rake install
```

To release a new version:

Update the version number in `lib/form_generator/version.rb`

Run:

```bash
bundle exec rake release
```

This will create a Git tag, push commits, and publish the gem to RubyGems.

Contributing

Contributions are welcome! Please follow these steps:

Fork the repository.

Create a new branch (`git checkout -b my-feature-branch`).

Make your changes and commit them (`git commit -m 'Add new feature'`).

Push to the branch (`git push origin my-feature-branch`).

Create a pull request on GitHub.
