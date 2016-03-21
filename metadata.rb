name "pptp_server"
maintainer       "Bowen Sun"
maintainer_email "bowensun@gmail.com"
license          "Apache 2.0"
description      "Installs pptpd"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.4"

depends 'iptables'
depends 'modules'
depends 'sysctl'
