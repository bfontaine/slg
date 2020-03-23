# -*- coding: UTF-8 -*-

require "uri"
require "open-uri"
require "nokogiri"

require "ud/formatting"

# Most of this code is copy/pasted from UD.
# TODO generalize the code in UD and reuse it here.

# This module provide some methods to scrape definitions from Slengo.it.
module Slg
  class << self
    # @return [String] the current gem's version
    def version
      "0.0.1"
    end

    WWW_ROOT = "https://slengo.it"

    # Get the search URL to query for a given term.
    # @param term [String] the term to search for. It must be a string, spaces
    #                      are allowed.
    # @return [String]
    def search_url(term)
      param = URI.encode_www_form_component(term).gsub(/\+/, "%20")
      "#{WWW_ROOT}/define/#{param}"
    end

    # Open the search URL in the user's browser
    # @param term [String] the term to search for. It must be a string, spaces
    #                      are allowed.
    # @return [Nil]
    def open_url(term)
      system open_cmd, search_url(term)
    end

    # Query the website and return a list of definitions for the provided term.
    # This list may be empty if there's no result.
    # @param term [String] the term to search for
    # @param opts [Hash] options. This is used by the command-line tool.
    #                    +:count+ is the maximum number of results to return
    # @return [Array<Hash>]
    def query(term, opts = {})
      url = search_url(term)
      text = OpenURI.open_uri url

      opts = { :count => 1 }.merge(opts || {})

      return [] if opts[:count] <= 0

      doc = Nokogiri::HTML.parse text

      doc.css("article.definition-card").map do |elt|
        examples = elt.css(".word-examples li").map(&:text).map(&:strip)
        example = examples.join "\n\n"

        votes = elt.css(".votes-container .v-progress-linear")
        # Slengo.it uses percentages instead of number of votes
        upvotes = votes.attr("aria-valuenow").to_s.to_i
        downvotes = 100 - upvotes

        header_p = elt.css("header p").first

        definition = elt.css("div.word-definition").text
        # Remove 'see also'
        definition.gsub! /\bCfr\..+/m, ""
        definition.strip!

        {
          # There's no :id nor :author
          # For some reason the selector 'h1.word-title' work in JS in the
          # browser but not with Nokogiri.
          :word => header_p.text.strip,
          :permalink => url,
          :definition => definition,
          :example => example,
          :upvotes => upvotes,
          :downvotes => downvotes,
          # TODO add region as well
        }

      end.take opts[:count]
    end

    # Format results for output
    # @param results [Array] this must be an array of results, as returned by
    #                        +Slg.query+.
    # @param color [Boolean] colored output
    # @return [String]
    def format_results(results, color = true)
      UD::Formatting.text(results, color)
    end

    def open_cmd
      case RbConfig::CONFIG["host_os"]
      when /darwin/
        "open"
      when /bsd|linux/
        "xdg-open"
      when /cygwin|mingw|mswin/
        "start"
      end
    end
  end
end
