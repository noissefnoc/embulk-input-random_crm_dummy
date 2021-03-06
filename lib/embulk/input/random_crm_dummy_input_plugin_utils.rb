require 'faker'
require 'securerandom'
require 'time'

module Embulk
  module Input
    module RandomCrmDummyInputPluginUtils
      DEFAULT_TRUE_RATIO = '0.5'.freeze
      MIN_LONG_VALUE = 0
      MAX_LONG_VALUE = 10_000
      BEFORE_POINT  = 4
      AFTER_POINT   = 2
      FROM_DATE_STR = '1970-01-01'.freeze
      DATE_FORMAT = '%Y-%m-%d'.freeze
      DEFAULT_STRING = 'This is dummy data.'.freeze

      def self.generate_dummy_boolean(config)
        true_ratio = config.fetch('true_ratio', DEFAULT_TRUE_RATIO).to_f
        Faker::Boolean.boolean(true_ratio)
      end

      def self.generate_dummy_double(config)
        if config.key?('dummy')
          double_type_to_dummy(config)
        else
          before_point = config.fetch('before_point', BEFORE_POINT)
          after_point = config.fetch('after_point', AFTER_POINT)

          Faker::Number.decimal(before_point, after_point)
        end
      end

      def self.generate_dummy_long(config)
        from = config.fetch('from', MIN_LONG_VALUE)
        to = config.fetch('to', MAX_LONG_VALUE)

        Faker::Number.between(from, to)
      end

      def self.generate_dummy_string(config)
        if config.key?('dummy')
          string_type_to_dummy(config)
        else
          config.fetch('default', DEFAULT_STRING)
        end
      end

      def self.generate_dummy_timestamp(config)
        from_str = config.fetch('from', FROM_DATE_STR)
        to_str = config.fetch('to', Date.today.strftime(DATE_FORMAT).to_s)

        begin
          from = Date.parse(from_str)
          to = Date.parse(to_str)
          dummy_timestamp = Time.parse(Faker::Date.between(from, to).to_s)
        rescue ArgumentError
          raise ConfigError.new, "invalid date format at #{config['name']}"
        end

        dummy_timestamp
      end

      def self.pick_from_list(config)
        if !config.key?('label') || !config['label'].instance_of?(Array)
          raise ConfigError.new,
                "invalid syntax at #{config['name']} list attribute required"
        end

        max = config['label'].size - 1
        config['label'][rand(0..max)]
      end

      def self.locale(locale)
        Faker::Config.locale = locale
      end

      def self.double_type_to_dummy(config)
        type = config['dummy']

        case type
        when 'latitude'
          Faker::Address.latitude
        when 'longitude'
          Faker::Address.longitude
        else
          raise ConfigError.new,
                "unsupported or unimplemented Faker type double: #{type}"
        end
      end

      def self.string_type_to_dummy(config)
        type = config['dummy']

        case type
        when 'city'
          Faker::Address.city
        when 'country'
          Faker::Address.country
        when 'email'
          Faker::Internet.safe_email
        when 'full_name'
          Faker::Name.name
        when 'list'
          pick_from_list(config)
        when 'phone_number'
          Faker::PhoneNumber.phone_number
        when 'postal_code'
          Faker::Address.postcode
        when 'state'
          Faker::Address.state
        when 'street'
          Faker::Address.street_address
        when 'url'
          Faker::Internet.url
        when 'uuid'
          SecureRandom.uuid
        else
          raise ConfigError.new,
                "unsupported or unimplemented Faker type string: #{type}"
        end
      end
    end
  end
end
