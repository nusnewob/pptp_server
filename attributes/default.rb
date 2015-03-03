default[:pptpd][:localip]   = "192.168.240.1"
default[:pptpd][:remoteip]   = "192.168.240.2-90"
default[:pptpd][:mtu]   = "1400"
default[:pptpd][:first_dns]   = "8.8.8.8"
default[:pptpd][:second_dns]   = "114.114.114.114"
default[:pptpd][:users] = [
  {
    "username" => "vpnuser1",
    "password" => "vpnpassword1",
  },
  {
    "username" => "vpnuser2",
    "password" => "vpnpassword2",
  },
]
