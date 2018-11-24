# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'latex_curriculum_vitae/version'

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |s|
  s.name = 'latex_curriculum_vitae'
  s.version = LatexCurriculumVitae::Version::STRING
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.3.0'
  s.authors = ['Sascha Manns']
  s.description = <<-DESCRIPTION
    latex_curriculum_vitae is a Rubygem which help you to write your job applications. The program aks you for all relevant data for compiling
    the curriculum vitae. It builds the motivational letter (if chosen in the gui), the cover and the cv.
  DESCRIPTION

  s.email = 'Sascha.Manns@outlook.de'
  s.files = `git ls-files bin data etc lib CONTRIBUTING.md CHANGELOG.md LICENSE.md MAINTENANCE.md README.md`
            .split($RS)
  s.bindir = 'bin'
  s.executables = ['latex_curriculum_vitae']
  s.extra_rdoc_files = ['CHANGELOG.md', 'LICENSE.md', 'MAINTENANCE.md', 'README.md']
  s.homepage = 'https://dev.azure.com/saigkill/latex_curriculum_vitae'
  s.licenses = ['GPL-3.0']
  s.summary = 'Tool to write your job applications'

  s.metadata = {
      'homepage_uri' => 'https://dev.azure.com/saigkill/latex_curriculum_vitae',
      'changelog_uri' => 'https://github.com/rubocop-hq/rubocop/blob/master/CHANGELOG.md',
      'source_code_uri' => 'https://dev.azure.com/saigkill/latex_curriculum_vitae',
      'documentation_uri' => 'https://saschamanns.de/doc-lcv',
      'bug_tracker_uri' => 'https://dev.azure.com/saigkill/latex_curriculum_vitae/_workitems'
  }

  s.add_runtime_dependency('rdoc', '~> 6.0')
  s.add_runtime_dependency('rake', '~> 12.3')
  s.add_runtime_dependency('rainbow', '~> 3.0')
  s.add_runtime_dependency('bundler', '~> 1.16')
  s.add_runtime_dependency('parseconfig', '~> 1.0')
  s.add_runtime_dependency('rspec', '~> 3.7')
  s.add_runtime_dependency('xdg', '~> 2.2')
end

# rubocop:enable Metrics/BlockLength