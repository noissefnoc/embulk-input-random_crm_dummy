require 'embulk/input/random_crm_dummy_input_plugin_utils'

module Embulk
  module Input
    class RandomCrmDummy < InputPlugin
      Plugin.register_input('random_crm_dummy', self)

      def self.transaction(config, &control)
        task = {}

        # settings for embulk
        task[:schema] = config.param('columns', :array)
        task[:rows] = config.param('rows', :integer, default: 10)
        task[:threads] = config.param('threads', :integer, default: 1)

        # settings for dummy data generator
        task[:locale] = config.param('locale', :string, default: 'en')

        columns = []

        task[:schema].each do |column|
          name = column['name']
          type = column['type'].to_sym

          columns << Column.new(nil, name, type, column['format'])
        end

        resume(task, columns, 1, &control)
      end

      def self.resume(task, columns, count, &control)
        task_reports = yield(task, columns, count)

        next_diff_config = {}
        next_diff_config
      end

      def init
        # initialization code:
        @schema = task[:schema]
        @rows_per_threads = task[:rows].div(task[:threads])
        RandomCrmDummyInputPluginUtils.locale(task[:locale])
      end

      def run
        rows = @rows_per_threads

        rows.times do
          records = schema_to_record(@schema)
          page_builder.add(records)
        end

        page_builder.finish

        task_report = {}
        task_report
      end

      def schema_to_record(schema)
        schema.collect do |config|
          type = config['type']

          case type
          when 'boolean'
            RandomCrmDummyInputPluginUtils.generate_dummy_boolean(config)
          when 'double'
            RandomCrmDummyInputPluginUtils.generate_dummy_double(config)
          when 'long'
            RandomCrmDummyInputPluginUtils.generate_dummy_long(config)
          when 'string'
            RandomCrmDummyInputPluginUtils.generate_dummy_string(config)
          when 'timestamp'
            RandomCrmDummyInputPluginUtils.generate_dummy_timestamp(config)
          else
            raise "unknown type: #{type}"
          end
        end
      end
    end
  end
end
