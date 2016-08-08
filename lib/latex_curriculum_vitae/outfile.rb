#!/usr/bin/env ruby
# encoding: utf-8
# @author Sascha Manns
# @abstract module for adding new applications on the csv table
#
# Copyright (C) 2015-2016  Sascha Manns <samannsml@directbox.com>
# License: MIT

# Dependencies
require 'csv'

# main module
module LatexCurriculumVitae
  # Module for creating and appending the outfile
  module CVOutfile
    # Method to adding the data into the csv file
    def self.add_to_outfile(jobtitle, company, contact, emailaddress, csvout)
      time = Time.new
      date = time.strftime('%Y-%m-%d')
      contact.gsub!('%20', ' ')
      jobtitle.gsub!('%20', ' ')
      jobtitle.gsub!('%26', '&')
      if File.exist?(csvout)
        puts 'do nothing'
      else
        FileUtils.touch(csvout)
        File.write "#{csvout}", <<EOF
date,company,job,contact,email,status
EOF
      end
      CSV.open("#{csvout}", 'a+') do |csv|
        # datum,firma,stelle,kontakt,email,status
        csv << ["#{date}", "#{company}", "#{jobtitle}", "#{contact}", "#{emailaddress}", 'Open']
      end
    end
  end
end
