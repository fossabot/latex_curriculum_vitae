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

# Dependencies
require 'fileutils'
require 'xdg'
require 'tmpdir'

require_relative 'latex_curriculum_vitae/entityfile'
require_relative 'latex_curriculum_vitae/cv'
require_relative 'latex_curriculum_vitae/cover'
require_relative 'latex_curriculum_vitae/email'
require_relative 'latex_curriculum_vitae/outfile'
require_relative 'latex_curriculum_vitae/notifier'
require_relative 'latex_curriculum_vitae/letter'
require_relative 'latex_curriculum_vitae/get-config'

# Main Class LatexCurriculumVitae
module LatexCurriculumVitae

  # Variables
  sys_xdg = XDG['CONFIG_HOME']
  data_xdg = XDG['DATA_HOME']
  sysconf_dir = "#{sys_xdg}/latex_curriculum_vitae"
  data_dir = "#{data_xdg}/latex_curriculum_vitae"
  entity_tex = "#{sysconf_dir}/entity.tex"
  csv_out = "#{sysconf_dir}/job-applications.csv"
  temp_dir = '/tmp/latex_curriculum_vitae'
  tmp_dir = "#{temp_dir}/build"

  name_of_pdf, name_of_cover, name_of_resume, name_of_letter, pdf_reader, shorten_url, bit_ly_user, bit_ly_apikey,
  mail_backend = LatexCurriculumVitae::GetConfig.get(sysconf_dir)

  # Get the needed Information for creating the application
  contact, email_address, job_title, contact_sex, company, letter,
      proactive, job_url, target = LatexCurriculumVitae::Entityfile.get_information(entity_tex)

  # Shorten shorten_url
  # TODO: Try to fix this in future
  # rubocop:disable Style/IfInsideElse
  if proactive == 'yes'
    job_url_checked = 'No URL available (Proactive)'
  else
    if shorten_url == 'yes'
      if job_url != ''
        job_url_checked = LatexCurriculumVitae::Entityfile.shorten_url(job_url, bit_ly_user,
                                                                       bit_ly_apikey)
      else
        puts 'No url given'
      end
    else
      job_url_checked = job_url
    end
  end

  # Remove old tempdir and copy data to tempdir
  FileUtils.rm_rf(temp_dir) if File.exist?("#{temp_dir}/Resume/cv_10.tex")
  FileUtils.mkdir(temp_dir)
  FileUtils.mkdir(tmp_dir)
  FileUtils.cp_r("#{data_dir}/.", temp_dir)

  # Create Motivational Letter
  if letter == 'yes'
    FileUtils.cd("#{temp_dir}/Motivational_Letter") do
      LatexCurriculumVitae::Letter.create_letter(tmp_dir, name_of_letter)
    end
  end

  # Create the cover
  FileUtils.cd("#{temp_dir}/Cover") do
    LatexCurriculumVitae::Cover.create_cover(name_of_cover, tmp_dir)
  end

  # Create the Curriculum Vitae
  FileUtils.cd("#{temp_dir}/Resume") do
    LatexCurriculumVitae::CV.create_cv(name_of_resume, tmp_dir)
  end

  # Final create and shrinking
  FileUtils.cd(tmp_dir) do
    LatexCurriculumVitae::CV.create_final_cv(letter, name_of_letter, name_of_resume, name_of_pdf, name_of_cover)
    LatexCurriculumVitae::CV.copy_home(name_of_pdf, data_dir)
  end

  # Add entry to Outfile
  CVOutfile.add_to_outfile(job_title, company, contact, email_address, csv_out,
                           job_url_checked)

  # Start evince to check the output file
  system("#{pdf_reader} #{data_dir}/#{name_of_pdf}.pdf")

  # Ask if result is ok
  LatexCurriculumVitae::Email.result_ok(contact, email_address, job_title, contact_sex, proactive,
                                        letter, name_of_pdf, sysconf_dir, data_dir, mail_backend, target)

  # Inform about creation is done
  LatexCurriculumVitae::Notify.run(job_title, data_dir)
end
