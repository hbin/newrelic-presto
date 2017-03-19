$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'presto-client'
require 'new_relic/presto'

require 'minitest/autorun'

NewRelic::Agent.require_test_helper
