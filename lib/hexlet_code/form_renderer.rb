# frozen_string_literal: true

# Form Renderer
class FormRenderer
  def self.prepare_inputs(inputs)
    "#{inputs.map(&:to_s).join}\n"
  end

  def self.prepare_submit(submit)
    return '' if submit[:options].nil?

    "  #{HexletCode::Tag.new(
      'input', submit[:options]
    )}\n"
  end

  def self.render_html(form_instance)
    prepared_inputs = prepare_inputs(form_instance.form_body[:inputs])
    prepared_submit = prepare_submit(form_instance.form_body[:submit])

    HexletCode::Tag.new('form', form_instance.form_body[:form_options]) do
      "#{prepared_inputs}#{prepared_submit}"
    end.to_s
  end
end
