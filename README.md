DESCRIPTION
===========

Installs pptpd, a Point to Point Tunneling Server.

REQUIREMENTS
============

Platform with a package named 'pptpd'.

LICENSE AND AUTHOR
==================

Copy from unmaintained [pptpd cookbook](https://supermarket.chef.io/cookbooks/pptpd)

Author:: James Lin (<linjunhalida@gmail.com>)

Origin Author:: David Ruan (<ruanwz@gmail.com>)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Usage

==================

Add this to node:

```
{
  "pptpd": {
    "localip": "192.168.240.1",
    "remoteip": "192.168.240.2-90",
    "mtu": "1400",
    "first_dns": "8.8.8.8",
    "second_dns": "114.114.114.114",
    "users": [
        {
        "username": "vpnuser1",
        "password": "vpnpassword1"
        },
        {
        "username": "vpnuser2",
        "password": "vpnpassword2"
        },
    ]
  }
}
```

Then include `recipe[pptp_server]` to run_list.
