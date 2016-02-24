require "version"
Gem::Specification.new do |s|
  s.name            = 'ircdgen'
  s.version         = IRCdGen::VERSION
  s.date            = '2016'
  s.summary         = "IRCd Configuration files generator"
  s.description     = <<-EOF
A small executable only application that generates IRCd Configuration files
EOF
  s.authors         = ["Ken Spencer"]
  s.email           = 'iota@electrocode.net'
  s.require_paths   = ["../lib"]
  s.executables     = "ircgenrb"
  s.files           = `git ls-files -z`.split("\x0")
  s.homepage        = 'http://electrocode.net/ircgenrb'
  s.license         = 'MIT'
end