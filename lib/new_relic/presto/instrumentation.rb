require 'new_relic/control'
require 'new_relic/agent/datastores'

DependencyDetection.defer do
  @name = :presto

  depends_on do
    defined?(::Presto) && !NewRelic::Control.instance['disable_presto']
  end

  executes do
    NewRelic::Agent.logger.info 'Installing Presto Instrumentation'
  end

  executes do
    ::Presto::Client::Client.class_eval do
      def query_with_newrelic_trace(query, &blk)
        callback = proc do |_result, scoped_metric, elapsed|
          NewRelic::Agent::Datastores.notice_sql(query, scoped_metric, elapsed)
        end

        NewRelic::Agent::Datastores.wrap('Presto', 'query', nil, callback) do
          query_without_newrelic_trace(query, &blk)
        end
      end
      alias_method :query_without_newrelic_trace, :query
      alias_method :query, :query_with_newrelic_trace

      def run_with_newrelic_trace(query)
        callback = proc do |_result, scoped_metric, elapsed|
          NewRelic::Agent::Datastores.notice_sql(query, scoped_metric, elapsed)
        end

        NewRelic::Agent::Datastores.wrap('Presto', 'run', nil, callback) do
          run_without_newrelic_trace(query)
        end
      end
      alias_method :run_without_newrelic_trace, :run
      alias_method :run, :run_with_newrelic_trace
    end
  end
end
