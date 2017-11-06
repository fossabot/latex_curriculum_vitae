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
require 'parseconfig'

# main module
module LatexCurriculumVitae
  # Module for creating the GetConfig
  module GetConfig
    # This method gets the configs from the config file
    # @param [String] sysconf_dir
    # @return [Array] name_of_pdf, name_of_cover, name_of_resume, name_of_letter, pdf_reader, shorten_url,
    # bit_ly_user, bit_ly_apikey
    def self.get(sysconf_dir)
      config = ParseConfig.new("#{sysconf_dir}/latex_curriculum_vitae.cfg")
      name_of_pdf = config['name_of_pdf']
      name_of_cover = config['name_of_cover']
      name_of_resume = config['name_of_resume']
      name_of_letter = config['name_of_letter']
      pdf_reader = config['pdf_reader']
      shorten_url = config['shorten_url']
      bit_ly_user = config['bitly_user']
      bit_ly_apikey = config['bitly_apikey']
      mail_backend = config['mail_backend']

      [name_of_pdf, name_of_cover, name_of_resume, name_of_letter, pdf_reader, shorten_url, bit_ly_user, bit_ly_apikey,
       mail_backend]
    end

    # Method for getting smtp configuration
    # @param [String] sysconf_dir
    # @return [Array] own_name, own_email_address, own_smtp, own_username, own_password, own_port, own_domain
    def self.get_smtp(sysconf_dir)
      config = ParseConfig.new("#{sysconf_dir}/latex_curriculum_vitae.cfg")
      # own_name = config['own_name']
      own_email_address = config['own_email_address']
      own_smtp = config['own_smtp']
      own_username = config['own_username']
      own_password = config['own_password']
      own_port = config['own_port'].to_i

      [own_email_address, own_smtp, own_username, own_password, own_port]
    end
  end
end
