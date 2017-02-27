# -*- ruby -*-
# Release:
# * update *.wiki markdown documentation for GitLab
# * enable :git
# * rake run_before_release
# * disable :git
# * Checkin
# * rake release
# * rake run_after_release

require 'rubygems'
require 'hoe'

# rubocop:disable Metrics/LineLength
############################################# DEVELOPING ZONE #########################################################
Hoe.plugin :bundler
Hoe.plugin :doofus
Hoe.plugin :email
#Hoe.plugins.delete :git
Hoe.plugin :git
Hoe.plugin :history
Hoe.plugin :highline
Hoe.plugin :manns
#Hoe.plugin :reek
Hoe.plugin :rdoc
Hoe.plugin :rubocop
Hoe.plugin :rubygems
Hoe.plugin :version
Hoe.plugin :website

Hoe.spec 'latex_curriculum_vitae' do
  developer('Sascha Manns', 'Sascha.Manns@mailbox.org')
  license 'MIT' # this should match the license in the README
  require_ruby_version '>= 2.2.0'

  email_to << 'ruby-talk@ruby-lang.org'
  email_to << 'TEX-D-L@LISTSERV.DFN.DE'

  self.history_file = 'History.rdoc'
  self.readme_file = 'README.rdoc'
  self.extra_rdoc_files = FileList['*.rdoc'].to_a
  self.post_install_message = '*** Run rake setup to finish the installation *** Please file bugreports and feature requests on: https://github.com/saigkill/latex_curriculum_vitae/issues'

  dependency 'notifier', '~> 0.5'
  dependency 'pony', '~> 1.11'
  dependency 'combine_pdf', '~> 0.2'
  dependency 'url_shortener', '~> 0.0.9'
  dependency 'xdg', '~> 2.2.3'

  extra_dev_deps << ['hoe-bundler', '~> 1.3']
  extra_dev_deps << ['hoe-git', '~> 1.6']
  extra_dev_deps << ['hoe-rubygems', '~> 1.0']
  extra_dev_deps << ['hoe-manns', '~> 1.5']
  extra_dev_deps << ['hoe-reek', '~> 1.1']
  extra_dev_deps << ['hoe-rubocop', '~> 1.0']
  extra_dev_deps << ['hoe-version', '~> 1.2']
  extra_dev_deps << ['hoe-seattlerb', '~> 1.3']
  extra_dev_deps << ['hoe', '~> 3.15']
  extra_dev_deps << ['rake', '~> 11.2']
  extra_dev_deps << ['simplecov', '~> 0.12']
  extra_dev_deps << ['coveralls', '~> 0.8']
  extra_dev_deps << ['rainbow', '~> 2.0']
  extra_dev_deps << ['bundler', '~> 1.11']
  extra_dev_deps << ['parseconfig', '~> 1.0']
  extra_dev_deps << ['rspec', '~> 3.5']
  extra_dev_deps << ['simplecov', '~> 0.10']
end

###################################### SETUP ZONE #####################################################################

require 'fileutils'
require 'xdg'
desc 'Setup'
task :setup do
  sysxdg = XDG['CONFIG_HOME']
  dataxdg = XDG['DATA_HOME']
  sysconfdir = "#{sysxdg}/latex_curriculum_vitae"
  datadir = "#{dataxdg}/latex_curriculum_vitae"
  FileUtils.mkdir(sysconfdir) if !File.exist?(sysconfdir)
  FileUtils.mkdir(datadir) if !File.exist?(datadir)
  FileUtils.cp('etc/latex_curriculum_vitae.cfg', "#{sysconfdir}") if !File.exist?("#{sysconfdir}/latex_curriculum_vitae.cfg")
  FileUtils.cp('etc/personal_data.tex', "#{sysconfdir}") if !File.exist?("#{sysconfdir}/personal_data.tex")
  FileUtils.cp_r('data/latex_curriculum_vitae/.', "#{datadir}") if !File.exist?("#{datadir}/Appendix")
  FileUtils.cp('data/latex_curriculum_vitae/Pictures/arbeitsagentur.png', "#{dataxdg}/icons")
  home = Dir.home
  FileUtils.rm_rf("#{home}/.rvm/rubies/default/lib/ruby/site_ruby/2.2.0/latex_curriculum_vitae") if File.exist?("#{home}/.rvm/rubies/default/lib/ruby/site_ruby/2.2.0/latex_curriculum_vitae/Resume/cv_10.tex")
  FileUtils.rm_rf("#{home}/.rvm/rubies/default/lib/ruby/site_ruby/2.2.0/latex_curriculum_vitae.rb") if File.exist?("#{home}/.rvm/rubies/default/lib/ruby/site_ruby/2.2.0/latex_curriculum_vitae.rb")
  puts 'Creating Launcher...'.color(:yellow)
  desktopfile = "#{dataxdg}/applications/latex_curriculum_vitae.desktop"
  FileUtils.touch(desktopfile)
  File.write "#{desktopfile}", <<EOF
[Desktop Entry]
Version=2.3
Type=Application
Name=latex_curriculum_vitae
GenericName=latex_curriculum_vitae
Comment=Job-Application Creator
Exec=latexcv.rb
Icon="#{dataxdg}/icons/arbeitsagentur.png"
Categories=Utility;Application;
EOF
  puts 'Setup is now finished. See the documentation to find out more about this gem.'

end

# vim: syntax=ruby
