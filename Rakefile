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
# Hoe.plugin :deveiate
Hoe.plugin :doofus
Hoe.plugin :email
Hoe.plugin :gemspec
# Hoe.plugin :gem_prelude_sucks
#Hoe.plugins.delete :git
Hoe.plugin :git
Hoe.plugin :history
Hoe.plugin :highline
#Hoe.plugin :inline
Hoe.plugin :manns
# Hoe.plugin :mercurial
# Hoe.plugin :perforce
Hoe.plugin :packaging
# Hoe.plugin :racc
# Hoe.plugin :rcov
Hoe.plugin :reek
Hoe.plugin :rdoc
Hoe.plugin :rubocop
Hoe.plugin :rubygems
# Hoe.plugin :seattlerb
Hoe.plugin :travis
Hoe.plugin :version
Hoe.plugin :website
Hoe.plugin :yard

Hoe.spec 'latex_curriculum_vitae' do
  developer('Sascha Manns', 'samannsml@directbox.com')
  license 'MIT' # this should match the license in the README
  require_ruby_version '>= 2.2.0'

  email_to << 'ruby-talk@ruby-lang.org'
  email_to << 'TEX-D-L@LISTSERV.DFN.DE'

  self.history_file = 'History.rdoc'
  self.readme_file = 'README.rdoc'
  self.extra_rdoc_files = FileList['*.rdoc'].to_a
  self.post_install_message = '*** Run rake setup to finish the installation (Backup your Latex sources first!!!) *** Please file bugreports and feature requests on: https://gitlab.com/saigkill/latex_curriculum_vitae/issues'

  dependency 'setup', '~> 5.2'
  dependency 'notifier', '~> 0.5'
  dependency 'pony', '~> 1.11'

  extra_dev_deps << ['coveralls', '~> 0.8']
  extra_dev_deps << ['hoe-bundler', '~> 1.2']
  extra_dev_deps << ['hoe-deveiate', '~> 0.7']
  extra_dev_deps << ['hoe-gemspec', '~> 1.0']
  extra_dev_deps << ['hoe-doofus', '~> 1.0']
  extra_dev_deps << ['hoe-git', '~> 1.6']
  extra_dev_deps << ['hoe-rubygems', '~> 1.0']
  extra_dev_deps << ['hoe-manns', '~> 1.4.2']
  extra_dev_deps << ['hoe-reek', '~> 1.0']
  extra_dev_deps << ['hoe-rubocop', '~> 0.1']
  extra_dev_deps << ['hoe-travis', '~> 1.2']
  extra_dev_deps << ['hoe-version', '~> 1.2']
  extra_dev_deps << ['hoe-yard', '~> 0.1']
  extra_dev_deps << ['hoe-seattlerb', '~> 1.3']
  extra_dev_deps << ['hoe-version', '~> 1.2']
  extra_dev_deps << ['hoe-packaging', '~> 1.1.0']
  extra_dev_deps << ['hoe', '~> 3.14']
  extra_dev_deps << ['ZenTest', '~> 4.11']
  extra_dev_deps << ['rake', '~> 10.0']
  extra_dev_deps << ['simplecov', '~> 0.7']
  extra_dev_deps << ['coveralls', '~> 0.8']
  extra_dev_deps << ['gem-release', '~> 0.7']
  extra_dev_deps << ['indexer', '~> 0.3']
  extra_dev_deps << ['reek', '~> 3.3']
  extra_dev_deps << ['rainbow', '~> 2.0']
  extra_dev_deps << ['bundler', '~> 1.10']
  extra_dev_deps << ['parseconfig', '~> 1.0']
  extra_dev_deps << ['minitest', '~> 5.8.1']
  extra_dev_deps << ['rspec', '~> 3.3']
  extra_dev_deps << ['rubocop', '~> 0.34']
  extra_dev_deps << ['simplecov', '~> 0.10']
  extra_dev_deps << ['bundler-audit', '~> 0.4.0']
end

###################################### SETUP ZONE #####################################################################

require 'fileutils'
desc 'Setup'
task :setup do
  datadir = "#{Dir.home}/.rvm/rubies/default/share"
  FileUtils.cp("#{Dir.home}/.latex_curriculum_vitae/.latex_curriculum_vitae.cfg",
               "#{Dir.home}/.latex_curriculum_vitae/.latex_curriculum_vitae.cfg.my") if
                File.exist?("#{Dir.home}/.latex_curriculum_vitae/.latex_curriculum_vitae.cfg")
  FileUtils.mkdir("#{datadir}/latex_curriculum_vitae-backup") if !File.exist?("#{datadir}/latex_curriculum_vitae-backup")
  FileUtils.cp_r "#{datadir}/latex_curriculum_vitae/.", "#{datadir}/latex_curriculum_vitae-backup/." if
                File.exist?("#{datadir}/latex_curriculum_vitae/")
  system('setup.rb uninstall --force')
  system('setup.rb config --sysconfdir=$HOME/.latex_curriculum_vitae')
  system('setup.rb install')
  FileUtils.cp("#{Dir.home}/.latex_curriculum_vitae/.latex_curriculum_vitae.cfg.my",
               "#{Dir.home}/.latex_curriculum_vitae/.latex_curriculum_vitae.cfg") if
                File.exist?("#{Dir.home}/.latex_curriculum_vitae/.latex_curriculum_vitae.cfg.my")
  FileUtils.cp_r "#{datadir}/latex_curriculum_vitae-backup/.", "#{datadir}/latex_curriculum_vitae/." if
                File.exist?("#{datadir}/latex_curriculum_vitae-backup/.")
  puts 'Creating Launcher...'.color(:yellow)
  desktopfile = "#{Dir.home}/.local/share/applications/latex_curriculum_vitae.desktop"
  FileUtils.touch(desktopfile)
  File.write "#{desktopfile}", <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Job-Application Creator
Exec=latexcv.rb
Icon="#{datadir}/latex_curriculum_vitae/Pictures/arbeitsagentur.png"
EOF
  puts 'Setup is now finished. See the documentation to find out more about this gem.'

end

# vim: syntax=ruby
