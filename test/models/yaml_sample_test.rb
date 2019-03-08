require "test_helper"

class YamlSampleTest < ActiveSupport::TestCase
  setup do
    @valid_yaml_sample =
      YamlSample.new(file_fixture("valid.yml.example").read)
    @invalid_yaml_sample =
      YamlSample.new(file_fixture("invalid.yml.example").read)
    @valid_yaml_sample_with_symbols =
      YamlSample.new(file_fixture("valid_with_symbols.yml.example").read)
  end

  # -----=====[ errors() ]=====-----

  test "should have no errors with valid YAML" do
    assert_nil(@valid_yaml_sample.errors)
  end

  test "should have an error with invalid YAML" do
    assert_includes(@invalid_yaml_sample.errors, :message)
  end

  test "should not show errors on a valid YAML file containing symbols" do
    assert_nil(@valid_yaml_sample_with_symbols.errors)
  end

  # -----=====[ locale() ]=====-----
  test "should give the locale of a valid YAML file" do
    assert_equal(@valid_yaml_sample.locale, :en)
  end

  test "should give no locale for an invalid YAML file" do
    assert_nil(@invalid_yaml_sample.locale)
  end
end
