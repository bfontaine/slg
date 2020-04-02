#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

require File.dirname(__FILE__) + '/fake_responses'

class Slg_Query_test < Test::Unit::TestCase
  def setup
    @foo, @bar = [
      {
        :definition=>"Foo foo.",
        :ratio=>1.0,
        :examples=> ["foo ex 1", "foo ex 2"],
        :permalink=>"https://slengo.it/define/culo",
        :word=>"foo",
      },
      {
        :definition=>"Bar bar.",
        :ratio=>0.9,
        :examples=>["bar ex"],
        :permalink=>"https://slengo.it/define/culo",
        :word=>"foo",
      }
    ]
  end

  def test_search_url
    assert_equal("https://slengo.it/define/foo", Slg.search_url('foo'))
  end

  def test_query_no_results
    assert_equal([], Slg.query('foooo'))
  end

  def test_query_two_results
    assert_equal([@foo, @bar], Slg.query('culo', :count => 2))
  end

  def test_query_count
    assert_equal([@foo], Slg.query('culo', :count => 1))
  end
end

