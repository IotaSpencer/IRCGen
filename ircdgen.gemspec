require_relative "lib/version"


Gem::Specification.new do |s|
  s.name                    = "ircdgen"
  s.version                 = Application.VERSION
  s.date                    = "2016-02-25"
  s.summary                 = "IRCd Configuration files generator"
  s.description             = <<-EOF
A small executable only application that generates IRCd Configuration files
EOF
  s.author                  = "Ken Spencer"
  s.email                   = "iota@electrocode.net"
  s.require_paths           = ["lib"]
  s.default_executable      = "ircdgen"
  s.executables             = "ircdgen"
  s.files                   = `git ls-files -z`.split("\x0")
  s.homepage                = "http://electrocode.net/ircgenrb"
  s.license                 = "MIT"
  s.add_runtime_dependency  "highline", "~> 0"
  s.add_runtime_dependency  "slop", "~> 0"
end
