require 'override_assert_raise'
require 'embulk/input/random_crm_dummy_input_plugin_utils'

class EmbulkInputPluginUtilTest < Test::Unit::TestCase
  def test_generate_dummy_boolean_true
    config = {'name'=> 'true_value', 'type'=> 'boolean', 'true_ratio'=> 1.0}
    expected = true
    actual = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_boolean(config)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_boolean_false
    config = {'name'=> 'false', 'type'=> 'boolean', 'true_ratio'=> 0.0}
    expected = false
    actual = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_boolean(config)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_double_without_option
    config = {'name'=> 'double', 'type'=> 'double'}
    expected = true
    raw_value = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_double(config)
    actual = (/-?\d{4}\.\d{2}/ === raw_value.to_s)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_double_with_option
    config = {'name'=> 'double', 'type'=> 'double', 'before_point'=> 7, 'after_point'=> 5}
    expected = true
    raw_value = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_double(config)
    actual = (/-?\d{7}\.\d{5}/ === raw_value.to_s)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_double_latitude
    config = {'name'=> 'latitude', 'type'=> 'double', 'dummy'=> 'latitude'}
    expected = true
    raw_value = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_double(config)
    actual = (/-*?\d{,3}\.\d{,15}/ === raw_value.to_s)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_double_longitude
    config = {'name'=> 'longitude', 'type'=> 'double', 'dummy'=> 'longitude'}
    expected = true
    raw_value = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_double(config)
    actual = (/-*?\d{,3}\.\d{,15}/ === raw_value.to_s)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_double_raise_exception
    config = {'name'=> 'exception', 'type'=> 'double', 'dummy'=> 'hoge'}

    assert_raise do
      Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_double(config)
    end
  end

  def test_generate_dummy_long_with_option
    from = 0
    to = 0
    config = {'name'=> 'long', 'type'=> 'long', 'from'=> from, 'to'=> to}
    expected = 0
    actual = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_long(config)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_long_without_option
    config = {'name'=> 'long', 'type'=> 'long'}
    expected = true
    raw_value = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_long(config)
    actual = raw_value.kind_of?(Fixnum)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_string_without_option_with_default
    config = {'name' => 'string', 'type'=> 'string', 'default' => 'test'}
    expected = 'test'
    actual = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_string(config)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_string_with_option_city
    config = {'name'=> 'city', 'type'=> 'string', 'dummy'=> 'city'}
    expected = true
    raw_value = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_string(config)
    actual = raw_value.kind_of?(String)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_string_with_option_country
    config = {'name'=> 'country', 'type'=> 'string', 'dummy'=> 'country'}
    expected = true
    raw_value = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_string(config)
    actual = raw_value.kind_of?(String)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_string_with_option_email
    config = {'name'=> 'email', 'type'=> 'string', 'dummy'=> 'email'}
    expected = true
    raw_value = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_string(config)
    actual = (/.+?@example.+?/ === raw_value)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_string_with_option_full_name
    config = {'name'=> 'full_name', 'type'=> 'string', 'dummy'=> 'full_name'}
    expected = true
    raw_value = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_string(config)
    actual = raw_value.kind_of?(String)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_timestamp_default
    config = {'name'=> 'timestamp', 'type'=> 'timestamp'}
    expected = true
    raw_value = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_timestamp(config)
    actual = (/\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}(\.\d{6})? \+\d{4}/ === raw_value.to_s)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_timestamp_with_option_from_to
    config = {'name'=> 'timestamp', 'type'=> 'timestamp', 'from' => '1970-01-01', 'to' => '1980-01-01'}
    expected = true
    raw_value = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_timestamp(config)
    actual = (/\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}(\.\d{6})? \+\d{4}/ === raw_value.to_s)

    assert_equal(expected, actual)
    #TODO: timestamp range check
  end

  def test_generate_dummy_timestamp_with_option_raise_exception_invalid_date_format
    config = {'name'=> 'timestamp', 'type'=> 'timestamp', 'from' => 'hoge', 'to' => '1980-01-01'}
    assert_raise do
      Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_timestamp(config)
    end
  end

  def test_generate_dummy_string_with_option_list_nomal
    config = {'name'=> 'list', 'type'=> 'string', 'dummy'=> 'list', 'label' => ['hoge']}
    expected = 'hoge'
    actual = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_string(config)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_string_with_option_list_raise_exception_no_label
    config = {'name'=> 'list', 'type'=> 'string', 'dummy'=> 'list'}
    assert_raise do
      Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_string(config)
    end
  end

  def test_generate_dummy_string_with_option_list_raise_exception_label_not_array
    config = {'name'=> 'list', 'type'=> 'string', 'dummy'=> 'list', 'label'=> 'error'}
    assert_raise do
      Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_string(config)
    end
  end

  def test_generate_dummy_string_with_option_phone_number
    config = {'name'=> 'phone_number', 'type'=> 'string', 'dummy'=> 'phone_number'}
    expected = true
    raw_value = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_string(config)
    actual = (/[0-9,\-]+/ === raw_value)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_string_with_option_postal_code
    config = {'name'=> 'postal_code', 'type'=> 'string', 'dummy'=> 'postal_code'}
    expected = true
    raw_value = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_string(config)
    actual = (/[0-9,\-]+/ === raw_value)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_string_with_option_state
    config = {'name'=> 'state', 'type'=> 'string', 'dummy'=> 'state'}
    expected = true
    raw_value = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_string(config)
    actual = raw_value.kind_of?(String)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_string_with_option_street
    config = {'name'=> 'street', 'type'=> 'string', 'dummy'=> 'street'}
    expected = true
    raw_value = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_string(config)
    actual = raw_value.kind_of?(String)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_string_with_option_url
    config = {'name'=> 'url', 'type'=> 'string', 'dummy'=> 'url'}
    expected = true
    raw_value = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_string(config)
    actual = actual = (/https?:\/\/.+/ === raw_value)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_string_with_option_uuid
    config = {'name'=> 'uuid', 'type'=> 'string', 'dummy'=> 'uuid'}
    expected = true
    raw_value = Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_string(config)
    actual = actual = (/[a-z0-9]+-[a-z0-9]+-[a-z0-9]+-[a-z0-9]+/ === raw_value)

    assert_equal(expected, actual)
  end

  def test_generate_dummy_string_with_option_raise_exception_does_not_exist_type
    config = {'name'=> 'does_not_exist_string', 'type'=> 'string', 'dummy'=> 'does_not_exist'}
    assert_raise do
      Embulk::Input::RandomCrmDummyInputPluginUtils.generate_dummy_string(config)
    end
  end

end
