require "generator"
class Bind < Builder
  attr :bind_address, :bind_port, :bind_wants_ssl, :bind_ssl

  def initialize()
    super
    say "Bind Address: If you have multiple IPs on your server, then you can bind to a certain one through this tag key. If you are going to listen on all, as the default is *, just press enter."
    @bind_address = ask "What IP are we listening on?" do |q|
      q.default = "*"
    end
    say "Bind Port(s): Here we enter what ports are open for the ircd. You can use ranges and multiple IPs, like '6660-6669,7000,8008'"
    @bind_port = ask "At what port(s) are we listening to?" do |q|
      q.gather = ""
    end
    if agree(" do you want ssl for this bind block?", true)
      choose do |menu|
        menu.prompt = ("What type of SSL do you want? Make sure you have it compiled!")
        menu.choice(:gnutls, "Use GNU TLS for ssl") do |m|
          @bind_ssl = "gnutls"
          @bind_wants_ssl = true
        end
        menu.choice(:openssl, "Use OpenSSL for ssl") do |m|
          @bind_ssl = "openssl"
          @bind_wants_ssl = true
        end
      end
    end
    print
  end
  def print
    puts "<bind address=\"#{@bind_address}\" port=\"#{@bind_port.join(",")}\""
    if @bind_wants_ssl
      Kernel.print " ssl=\"#{@bind_ssl}\""
    end
    Kernel.print ">\n"
  end
end
