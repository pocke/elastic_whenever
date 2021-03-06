module ElasticWhenever
  class Task
    class Definition
      def initialize(option, family)
        @client = Aws::ECS::Client.new(option.aws_config)
        @definition = client.describe_task_definition(
          task_definition: family
        ).task_definition
      end

      def name
        "#{definition.family}:#{definition.revision}" if definition
      end

      def arn
        definition&.task_definition_arn
      end

      private

      attr_reader :client
      attr_reader :definition
    end
  end
end