# Copyright (C) 2015-2018 Sascha Manns <Sascha.Manns@outlook.de>
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

# main module
module LatexCurriculumVitae
  # This module holds the latex_curriculum_vitae version information.

  module Version
    STRING = '2.1.2'.freeze
    MSG = '%<version>s (using Parser %<parser_version>s, running on ' \
    '%<ruby_engine>s %<ruby_version>s %<ruby_platform>s)'.freeze

    def self.version(debug = false)
      if debug
        format(MSG, version: STRING, parser_version: Parser::VERSION,
               ruby_engine: RUBY_ENGINE, ruby_version: RUBY_VERSION,
               ruby_platform: RUBY_PLATFORM)
      else
        STRING
      end
    end
  end
end
