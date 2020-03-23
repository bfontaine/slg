#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

require File.dirname(__FILE__) + '/fake_responses'

class Slg_Query_test < Test::Unit::TestCase
  def setup
    @foo, @bar = [
      {
        :definition=>"Foo foo.",
        :downvotes=>0,
        :example=> "foo ex 1\n\nfoo ex 2",
        :permalink=>"https://slengo.it/define/culo",
        :upvotes=>100,
        :word=>"foo",
      },
      {
        :definition=>"Bar bar.",
        :downvotes=>10,
        :example=>"bar ex",
        :permalink=>"https://slengo.it/define/culo",
        :upvotes=>90,
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

