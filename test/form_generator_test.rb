# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/form_generator'

User = Struct.new(:name, :job, keyword_init: true)

describe 'form_generator' do
  user = User.new name: 'rob', job: 'developer'

  it 'should generate a form' do
    assert_equal '<form action="#" method="post"></form>', FormGenerator.form_for(user).to_s
  end

  it 'should generate a form with fields' do
    assert_equal '<form action="#" method="post" class="form"></form>', FormGenerator.form_for(user,
                                                                                               class: 'form').to_s
  end

  it 'should generate a form with multiple attributes' do
    assert_equal '<form action="/users" method="post" class="form"></form>', FormGenerator.form_for(user,
                                                                                                    url: '/users',
                                                                                                    class: 'form').to_s
  end

  it 'should generate an input field' do
    assert_equal '<input name="name" value="rob" />',
                 FormGenerator.form_for(user).input(:name).to_s
  end

  it 'should generate a text area' do
    assert_equal '<textarea name="name" value="rob"></textarea>',
                 FormGenerator.form_for(user).input(:name, as: :text).to_s
  end

  it 'should generate a form with input' do
    result = FormGenerator.form_for(user) do |f|
      f.input :name
    end.to_s

    assert_equal '<form action="#" method="post"><label for="name">Name</label><input name="name" value="rob" /></form>',
                 result
  end

  it 'should generate a form with multiple inputs' do
    result = FormGenerator.form_for(user) do |f|
      f.input :name
      f.input :job
    end

    assert_equal '<form action="#" method="post"><label for="name">Name</label><input name="name" value="rob" /><label for="job">Job</label><input name="job" value="developer" /></form>',
                 result.to_s
  end
  it 'should generate a form with multiple inputs and textarea' do
    result = FormGenerator.form_for(user) do |f|
      f.input :name
      f.input :job, as: :text
    end

    assert_equal '<form action="#" method="post"><label for="name">Name</label><input name="name" value="rob" /><label for="job">Job</label><textarea name="job" value="developer"></textarea></form>',
                 result.to_s
  end
  it 'should add attributes to inputs' do
    result = FormGenerator.form_for(user) do |f|
      f.input :name, class: 'input'
      f.input :job, as: :text, class: 'textarea'
    end

    assert_equal '<form action="#" method="post"><label for="name">Name</label><input class="input" name="name" value="rob" /><label for="job">Job</label><textarea class="textarea" name="job" value="developer"></textarea></form>',
                 result.to_s
  end
  it 'should generate submit button with default value' do
    assert_equal '<input type="submit" value="Save" />',
                 FormGenerator.form_for(user).submit.to_s
  end
  it 'should generate submit button with default value' do
    assert_equal '<input type="submit" value="Save" />',
                 FormGenerator.form_for(user).submit.to_s
  end
  it 'should generate submit button with custom value' do
    assert_equal '<input type="submit" value="Wow" />',
                 FormGenerator.form_for(user).submit('Wow').to_s
  end
  it 'should generate a form with a submit button' do
    result = FormGenerator.form_for(user) do |f|
      f.input :name, class: 'input'
      f.input :job, as: :text, class: 'textarea'
      f.submit
    end

    assert_equal '<form action="#" method="post"><label for="name">Name</label><input class="input" name="name" value="rob" /><label for="job">Job</label><textarea class="textarea" name="job" value="developer"></textarea><input type="submit" value="Save" /></form>',
                 result.to_s
  end
  it 'should throw an error if the field is not present' do
    assert_raises('Key or method `not_present` not found in the provided struct') do
      FormGenerator.form_for(user) do |f|
        f.input :not_present
      end
    end
  end
end
