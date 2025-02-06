# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/hexlet_code"

User = Struct.new(:name, :job, keyword_init: true)

user = User.new name: "rob", job: "developer"

describe "form_builder" do
  it "should generate a form" do
    expected = <<~HTML.strip
      <form action="#" method="post">
      </form>
    HTML
    assert_equal expected, HexletCode.form_for(user)
  end

  it "should generate a form with fields" do
    expected = <<~HTML.strip
      <form action="#" method="post" class="form">
      </form>
    HTML

    assert_equal expected, HexletCode.form_for(user,
                                               class: "form")
  end

  it "should generate a form with multiple attributes" do
    expected = <<~HTML.strip
      <form action="/users" method="post" class="form">
      </form>
    HTML

    assert_equal expected, HexletCode.form_for(user,
                                               url: "/users",
                                               class: "form")
  end
end

describe "key validation" do
  it "should throw an error if the field is not present" do
    assert_raises("Key or method `not_present` not found in the provided struct") do
      HexletCode.form_for(user) do |f|
        f.input :not_present
      end
    end
  end
end

describe "form_generator_with_field" do
  it "should generate a form with input" do
    result = HexletCode.form_for(user) do |f|
      f.input :name, class: "input"
    end.to_s

    expected = <<~HTML.strip
      <form action="#" method="post">
        <label for="name">Name</label>
        <input class="input" name="name" value="rob" type="text" />
      </form>
    HTML

    assert_equal expected, result
  end
end

describe "form_generator_with_textarea_and_inputs" do
  it "should generate a form with multiple inputs and textarea" do
    result = HexletCode.form_for(user) do |f|
      f.input :name
      f.input :job, as: :text
    end.to_s

    expected = <<~HTML.strip
      <form action="#" method="post">
        <label for="name">Name</label>
        <input name="name" value="rob" type="text" />
        <label for="job">Job</label>
        <textarea name="job">developer</textarea>
      </form>
    HTML

    assert_equal expected, result
  end
end

describe "submit generator" do
  it "should generate a form with a submit button" do
    result = HexletCode.form_for(user) do |f|
      f.input :name, class: "input"
      f.input :job, as: :text, class: "textarea"
      f.submit
    end.to_s

    expected = <<~HTML.strip
      <form action="#" method="post">
        <label for="name">Name</label>
        <input class="input" name="name" value="rob" type="text" />
        <label for="job">Job</label>
        <textarea class="textarea" name="job">developer</textarea>
        <input type="submit" value="Save" />
      </form>
    HTML

    assert_equal expected, result
  end
end
