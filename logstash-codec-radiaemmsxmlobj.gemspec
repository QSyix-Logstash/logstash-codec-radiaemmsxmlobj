Gem::Specification.new do |s|
  s.name          = 'logstash-codec-radiaemmsxmlobj'
  s.version       = '0.1.0'
  s.licenses      = ['Apache-2.0']
  s.summary       = 'Converts message to Radia Endpoing Manager Messaging Server XML Object format'
  s.description   = 'Converts message to Radia Endpoing Manager Messaging Server XML Object format'
  s.homepage      = 'https://github.com/mjamshedqureshi/logstash-codec-radiaemmsxmlobj'
  s.authors       = ['mjamshedqureshi']
  s.email         = 'quiz.oxis@gmail.com'
  s.require_paths = ['lib']

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "codec" }

  # Gem dependencies
  s.add_runtime_dependency 'logstash-core-plugin-api', "~> 2.0"
  s.add_runtime_dependency 'logstash-codec-line'
  s.add_development_dependency 'logstash-devutils'
end
