class YamlSample
  include ActiveModel::Model
  attr_accessor :text, :file_name

  def initialize(text, file_name = nil)
    @text = text
    @file_name = file_name
  end

  # Validates the syntax of the YAML.
  # Returns a hash containing information about the first error found when
  # parsing the YAML, or nil if no errors are found.
  def errors
    yaml_errors = nil
    begin
      YAML.safe_load(@text, [Symbol])
    rescue Psych::SyntaxError => e
      yaml_errors = {
        line: e.line,
        column: e.column,
        message: e.message
      }
    end
    yaml_errors
  end

  # Determine the locale of the YAML.
  # Based off of rails i18n YAML file structure where the first key
  # is the locale.
  # Returns a symbol of the samples locale, or nil if the yaml is invalid.
  def locale
    return nil if errors

    locale = YAML.safe_load(@text).keys.first
    locale.to_sym
  end

  def persisted?
    false
  end
end
