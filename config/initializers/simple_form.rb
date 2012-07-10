SimpleForm.setup do |config|
  config.wrappers :default, class: :input, hint_class: 'field-with-hint', error_class: 'field-with-errors' do |b|
    b.use :html5

    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label_input
    b.use :hint,  wrap_with: {tag: :span, class: :hint}
    b.use :error, wrap_with: {tag: :span, class: :error}
  end

  config.default_wrapper = :default

  config.boolean_style = :inline
  config.error_notification_tag = :div
  config.error_notification_class = 'alert alert-error'
  config.required_by_default = false
  config.browser_validations = false
  config.label_text = lambda { |label, required| "#{label}#{required}" }
end
