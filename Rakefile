# -*- ruby -*-
# Release:
# See README.rdoc.releasing

require 'rubygems'
require 'hoe'

# rubocop:disable Metrics/LineLength
############################################# DEVELOPING ZONE #########################################################
Hoe.plugin :bundler
Hoe.plugin :doofus
Hoe.plugin :git
Hoe.plugin :manns
Hoe.plugin :rdoc
Hoe.plugin :reek
Hoe.plugin :rubocop
Hoe.plugin :rubygems
Hoe.plugin :travis
Hoe.plugin :version

Hoe.spec 'latex_curriculum_vitae' do
  developer('Sascha Manns', 'Sascha.Manns@mailbox.org')
  license 'GPL-3' # this should match the license in the README
  require_ruby_version '>= 2.2.0'

  self.history_file = 'History.rdoc'
  self.readme_file = 'README.rdoc'
  self.extra_rdoc_files = FileList['*.rdoc'].to_a
  self.post_install_message = '*** Run rake setup to finish the installation *** Please file bugreports on: https://bugs.launchpad.net/latexcv'

  dependency 'notifier', '~> 0.5'
  dependency 'pony', '~> 1.11'
  dependency 'combine_pdf', '~> 1.0'
  dependency 'url_shortener', '~> 0.0.9'
  dependency 'xdg', '~> 2.2'

  extra_dev_deps << ['hoe-bundler', '~> 1.3']
  extra_dev_deps << ['hoe-doofus', '~> 1.0']
  extra_dev_deps << ['hoe-git', '~> 1.6']
  extra_dev_deps << ['hoe-rubygems', '~> 1.0']
  extra_dev_deps << ['hoe-manns', '~> 1.6']
  extra_dev_deps << ['hoe-reek', '~> 1.2']
  extra_dev_deps << ['hoe-rubocop', '~> 1.0']
  extra_dev_deps << ['hoe-travis', '~> 1.3']
  extra_dev_deps << ['hoe-version', '~> 1.2']
  extra_dev_deps << ['hoe', '~> 3.16']
  extra_dev_deps << ['rake', '~> 12.2']
  extra_dev_deps << ['rdoc', '~> 5.1']
  extra_dev_deps << ['reek', '~> 4.7']
  extra_dev_deps << ['rubocop', '~> 0.51']
  extra_dev_deps << ['coveralls', '~> 0.8']
  extra_dev_deps << ['rainbow', '~> 2.2']
  extra_dev_deps << ['bundler', '~> 1.16']
  extra_dev_deps << ['parseconfig', '~> 1.0']
  extra_dev_deps << ['rspec', '~> 3.7']
end

###################################### SETUP ZONE #####################################################################

require 'fileutils'
require 'xdg'
desc 'Setup'
task :setup do
  sys_xdg = XDG['CONFIG_HOME']
  data_xdg = XDG['DATA_HOME']
  sysconf_dir = "#{sys_xdg}/latex_curriculum_vitae"
  data_dir = "#{data_xdg}/latex_curriculum_vitae"
  home = Dir.home
  FileUtils.mkdir(sysconf_dir) if !File.exist?(sysconf_dir)
  FileUtils.mkdir(data_dir) if !File.exist?(data_dir)
  FileUtils.cp('etc/latex_curriculum_vitae.cfg', "#{sysconf_dir}") if !File.exist?
  ("#{sysconf_dir}/latex_curriculum_vitae.cfg")
  FileUtils.cp('etc/personal_data.tex', "#{sysconf_dir}") if !File.exist?("#{sysconf_dir}/personal_data.tex")
  FileUtils.cp_r('data/latex_curriculum_vitae/.', "#{data_dir}") if !File.exist?("#{data_dir}/Appendix")
  FileUtils.cp('data/latex_curriculum_vitae/Pictures/arbeitsagentur.png', "#{data_xdg}/icons")
  puts 'Creating Launcher...'.color(:yellow)
  desktop_file = "#{data_xdg}/applications/latex_curriculum_vitae.desktop"
  FileUtils.touch(desktop_file)
  File.write "#{desktop_file}", <<EOF
[Desktop Entry]
Version=2.3
Type=Application
Name=latex_curriculum_vitae
GenericName=latex_curriculum_vitae
Comment=Job-Application Creator
Exec=latexcv.rb
Icon="#{data_xdg}/icons/arbeitsagentur.png"
Categories=Utility;Application;
EOF
  puts 'Setup is now finished. See the documentation to find out more about this gem.'

end

# vim: syntax=ruby
