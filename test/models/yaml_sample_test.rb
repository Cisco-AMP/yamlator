require "test_helper"

class YamlSampleTest < ActiveSupport::TestCase
  setup do
    @valid_yaml_sample =
      YamlSample.new(file_fixture("valid.yml.example").read)
    @invalid_yaml_sample =
      YamlSample.new(file_fixture("invalid.yml.example").read)
  end

  # -----=====[ errors() ]=====-----

  test "should have no errors with valid YAML" do
    assert_nil(@valid_yaml_sample.errors)
  end

  test "should have an error with invalid yaml" do
    assert_includes(@invalid_yaml_sample.errors, :message)
  end

  # -----=====[ locale() ]=====-----
  test "should give the locale of a valid yaml file" do
    assert_equal(@valid_yaml_sample.locale, :en)
  end

  test "should give no locale for an invalid yaml file" do
    assert_nil(@invalid_yaml_sample.locale)
  end
end
