#!/usr/bin/env ruby
# encoding: utf-8
# @author Sascha Manns
# @abstract module for adding new applications on the csv table
#
# Copyright (C) 2015-2017 Sascha Manns <Sascha.Manns@mailbox.org>
# License: MIT

# Dependencies
require 'csv'

# main module
module LatexCurriculumVitae
  # Module for creating and appending the outfile
  module CVOutfile
    # Method to adding the data into the csv file
    # @param [String] jobtitle Title of the job application
    # @param [String] company Companyname for the application
    # @param [String] contact Name of the Contact in the Company
    # @param [String] emailaddress Emailaddress of the Contact
    # @param [String] csvout Name of the CSV-Outfile
    # @param [String] joburl The shortened URL
    def self.add_to_outfile(jobtitle, company, contact, emailaddress, csvout, joburl)
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
date,company,job,contact,email,status, joburl
EOF
      end
      CSV.open("#{csvout}", 'a+') do |csv|
        # datum,firma,stelle,kontakt,email,status,joburl
        csv << ["#{date}", "#{company}", "#{jobtitle}", "#{contact}", "#{emailaddress}", 'Open', "#{joburl}"]
      end
    end
  end
end
