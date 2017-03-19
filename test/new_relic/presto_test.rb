require 'test_helper'

module NewRelic
  class PrestoTest < Minitest::Test
    def setup
      NewRelic::Agent.drop_buffered_data

      @client = ::Presto::Client.new({})
    end

    def test_that_it_has_a_version_number
      refute_nil ::NewRelic::Presto::VERSION
    end
  end
end
