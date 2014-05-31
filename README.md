# BTMview

BitMessage web interface

## Purpose

Allows you to run BitMessage on a remote server, and access it through a
simple web interface.

This project is still under heavy developments and tests — please use Github issues
in order to report any problem.

## Installation

It requires the following system perl modules:

* libcpanplus-perl
* libmodule-install-perl
* libcatalyst-perl
* libcatalyst-devel-perl

### Deploy steps
```
git clone https://github.com/EthACKdotOrg/BTMview.git
cd BTMview
# edit env-perl.sh if necessary
source env-perl.sh
perl Makefile.PL
make
# edit script/deploy for initial username/password
script/deploy
# edit btmview.conf file
script/btmview_server -p 5001
firefox localhost:5001
```
### Configuration steps
The only configuration file needing edition is the btmview.conf file. Please look inside btmview.conf.sample
file in order to get the verbs.

You also should [enable BitMessage API](https://bitmessage.org/wiki/API_Reference#Enable_the_API). Be sure to use the same username, password
and port. Also, BitMessage API listens to localhost by default, please ensure this is what you need.

## EthACK
This application is provided by [EthACK](https://ethack.org/), the Swiss Privacy Basecamp.

## License
BTMview code is released under the GPLv2 license.

Some external stuff are used in this project, and are released under other license:
* [Bootstrap](http://getbootstrap.com/) — [MIT license](http://en.wikipedia.org/wiki/MIT_License)
* [JQuery](https://jquery.com/) — [MIT license](http://en.wikipedia.org/wiki/MIT_License)
