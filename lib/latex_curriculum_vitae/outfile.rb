# Copyright (C) 2015-2017 Sascha Manns <Sascha.Manns@mailbox.org>
#
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
    # @param [String] job_title Title of the job application
    # @param [String] company Companyname for the application
    # @param [String] contact Name of the Contact in the Company
    # @param [String] email_address Emailaddress of the Contact
    # @param [String] csv_out Name of the CSV-Outfile
    # @param [String] job_url_checked The shortened URL
    # TODO: Try to fix this in future
    # rubocop:disable Metrics/AbcSize
    # This method smells of :reek:LongParameterList
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
        # rubocop:disable IndentHeredoc
        File.write csv_out.to_s, <<CSV
date,company,job,contact,email,status, joburl
CSV
      end
      CSV.open(csv_out.to_s, 'a+') do |csv|
        # datum,firma,stelle,kontakt,email,status,joburl
        csv << [date.to_s, company.to_s, job_title.to_s, contact.to_s, email_address.to_s, 'Open', job_url_checked.to_s]
      end
    end
  end
end
