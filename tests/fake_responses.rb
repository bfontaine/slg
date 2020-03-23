#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

require 'webmock'
include WebMock::API

RESPONSES_DIR = "#{File.expand_path(File.dirname(__FILE__))}/responses"
BASE_URL = 'https://slengo.it/define'

WebMock.enable!
WebMock.disable_net_connect!(allow: %r[^https?://coveralls\.io])

Dir["#{RESPONSES_DIR}/*.html.resp"].each do |f|
  next if f !~ /\/(\w+)\.html.resp$/
  term = $1
  puts "registering fake response for #{term}",
  WebMock.stub_request(
    :get,
    "#{BASE_URL}/#{term}",
  ).to_return(
    body: File.read(f),
  )
end
