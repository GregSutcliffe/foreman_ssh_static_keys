$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ssh_static_keys/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = %q{ssh_static_keys}
  s.version     = SshStaticKeys::VERSION
  s.authors = ["Greg Sutcliffe"]
  s.email = "greg.sutcliffe@gmail.com"
  s.description = "Generate static SSH host keys by :id"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = Dir["{app,extra,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]
  s.homepage = "http://github.com/GregSutcliffe/ssh_static_keys"
  s.licenses = ["GPL-3"]
  s.summary = "SSH Key Plugin for Foreman"
end
