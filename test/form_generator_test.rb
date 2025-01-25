# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/form_generator'

User = Struct.new(:name, :job, keyword_init: true)

describe 'form_generator' do
  user = User.new name: 'rob'

  it 'should generate a form' do
    assert_equal FormGenerator.form_for(user), '<form action="#" method="post"></form>'
  end

  it 'should generate a form with fields' do
    assert_equal FormGenerator.form_for(user,
                                        class: 'form'), '<form action="#" method="post" class="form"></form>'
  end

  it 'should generate a form with multiple attributes' do
    assert_equal FormGenerator.form_for(user,
                                        url: '/users',
                                        class: 'form'), '<form action="/users" method="post" class="form"></form>'
  end
end
