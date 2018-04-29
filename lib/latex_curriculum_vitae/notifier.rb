# Copyright (C) 2015-2018 Sascha Manns <Sascha.Manns@mailbox.org>
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

# Module for notify the user
require 'notifier'

# main module
module LatexCurriculumVitae
  # Method for notifying the user
  module Notify
    # @param [String] job_title The Title of your job application
    # @param [String] data_dir Path to data dir
    def self.run(job_title, data_dir)
      img = "#{data_dir}/share/icons/arbeitsagentur.png"
      Notifier.notify(
        image: img.to_s,
        title: 'Your Job Application',
        message: "Your Job Application #{job_title} was created now."
      )
    end
  end
end
