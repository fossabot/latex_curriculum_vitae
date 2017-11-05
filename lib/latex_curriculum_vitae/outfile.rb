# encoding: utf-8
# Copyright (C) 2015-2017 Sascha Manns <Sascha.Manns@mailbox.org>
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
    def self.add_to_outfile(job_title, company, contact, email_address, csv_out, job_url_checked)
      time = Time.new
      date = time.strftime('%Y-%m-%d')
      contact.gsub!('%20', ' ')
      job_title.gsub!('%20', ' ')
      job_title.gsub!('%26', '&')
      if File.exist?(csv_out)
        puts 'do nothing'
      else
        FileUtils.touch(csv_out)
        File.write "#{csv_out}", <<EOF
date,company,job,contact,email,status, joburl
EOF
      end
      CSV.open("#{csv_out}", 'a+') do |csv|
        # datum,firma,stelle,kontakt,email,status,joburl
        csv << ["#{date}", "#{company}", "#{job_title}", "#{contact}", "#{email_address}", 'Open', "#{job_url_checked}"]
      end
    end
  end
end
