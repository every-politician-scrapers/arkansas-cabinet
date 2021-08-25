#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      Name.new(
        full: raw_name,
        prefixes: %w[Dr Major General],
      ).short
    end

    def position
      "Secretary of the #{department}"
    end

    private

    def raw_name
      noko.xpath('.//a[1]/following-sibling::text()[1]').text.tidy
    end

    def department
      noko.css('a').last.text.tidy
    end
  end

  class Members
    def member_container
      noko.css('.board-member')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
