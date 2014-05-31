# BTMview

BitMessage web interface

## Purpose

Allow you to run BitMessage on a remote server, and access it through a
simple web interface.

This project is still under heavy developments and tests — please use Github issues
in order to report any problem.

## Installation

```
git clone https://github.com/EthACKdotOrg/BTMview.git
cd BTMview
perl Makefile.PL
make
```

It requires the following system perl modules:

* libcpanplus-perl
* libmodule-install-perl
* libcatalyst-perl
* libcatalyst-devel-perl
* libcatalyst-plugin-session-state-cookie-perl
* libcatalyst-plugin-session-store-file-perl
* libcatalyst-plugin-authentication-perl
* libcatalyst-plugin-static-simple-perl
* libcatalyst-plugin-configloader-perl

Runs smoothly on a Debian Wheezy.
