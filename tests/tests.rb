#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

ci = ENV["CI"] || ENV["CONTINUOUS_INTEGRATION"]

if ci
  require 'coveralls'
  Coveralls.wear!
end

require 'test/unit'
require 'simplecov'

test_dir = File.expand_path( File.dirname(__FILE__) )

SimpleCov.formatter = Coveralls::SimpleCov::Formatter if ci
SimpleCov.start { add_filter '/tests/' }

require 'slg'

for t in Dir.glob( File.join( test_dir,  '*_tests.rb' ) )
  require t
end

class SlgTests < Test::Unit::TestCase

  def test_slg_version
    assert(Slg.version =~ /^\d+\.\d+\.\d+/)
  end

  def test_slg_open_cmd
    os = RbConfig::CONFIG["host_os"]

    RbConfig::CONFIG["host_os"] = "darwin"
    assert_equal "open", Slg.send(:open_cmd)

    RbConfig::CONFIG["host_os"] = "linux"
    assert_equal "xdg-open", Slg.send(:open_cmd)

    RbConfig::CONFIG["host_os"] = "bsd"
    assert_equal "xdg-open", Slg.send(:open_cmd)

    RbConfig::CONFIG["host_os"] = "cygwin"
    assert_equal "start", Slg.send(:open_cmd)

  ensure
    RbConfig::CONFIG["host_os"] = os
  end

end


exit Test::Unit::AutoRunner.run
