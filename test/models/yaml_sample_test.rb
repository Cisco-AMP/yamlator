require 'test_helper'

class YamlSampleTest < ActiveSupport::TestCase
  def setup
    @valid_yaml_sample =
      YamlSample.new(file_fixture('valid.yml.example').read)
    @invalid_yaml_sample =
      YamlSample.new(file_fixture('invalid.yml.example').read)
  end

  def test_errors_with_valid_yaml
    assert_nil(@valid_yaml_sample.errors)
  end

  def test_errors_with_invalid_yaml
    assert_includes(@invalid_yaml_sample.errors, :message)
  end

  def test_locale_with_valid_yaml
    assert_equal(@valid_yaml_sample.locale, :en)
  end

  def test_locale_with_invalid_yaml
    assert_nil(@invalid_yaml_sample.locale)
  end
end
