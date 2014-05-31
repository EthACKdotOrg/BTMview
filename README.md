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
NOTE: there's a small thing preventing the app to display properly when you run it this way. It's intended to
be placed behind some proxy, like [Nginx](http://nginx.org/). In order to run it "as is", please edit the following
file: ```lib/btmview/View/HTML.pm``` and modify the ```get_rel``` function:
``` Perl
=head2 get_rel
return url to file with mtime
=cut
sub get_rel {
  my ( $self, $c, $file ) = @_;
  my $time = 100020;
  eval {
    $time = stat('root/static/'.$file)->mtime;
  };
  return $file.'?mtime='.int($time);
  return '/static/'.$file;
}
```

### Configuration steps
The only configuration file needing edition is the btmview.conf file. Please look inside btmview.conf.sample
file in order to get the verbs.

You also should [enable BitMessage API](https://bitmessage.org/wiki/API_Reference#Enable_the_API). Be sure to use the same username, password
and port. Also, BitMessage API listens to localhost by default, please ensure this is what you need.

### Nginx proxy sample
```
server {
  listen        80;
  server_name   btmview.domain.tld; # EDIT THIS LINE
  add_header X-Frame-Options SAMEORIGIN;

  if ($http_transfer_encoding ~* chunked) {
    return 444;
  }

  location ^~ /static/ {
    expires 10y;
    add_header Cache-Control "public; proxy-revalidate";
    rewrite ^/static/[0-9]+/(.*)$ /static/$1 ;

    root /srv/btmview/root ; # EDIT THIS LINE
  }
  location / {
    proxy_set_header  Host $host;
    default_type   text/html;
    fastcgi_pass   btmview.domain.tld; # EDIT THIS LINE
    fastcgi_param  QUERY_STRING       $query_string;
    fastcgi_param  REQUEST_METHOD     $request_method;
    fastcgi_param  CONTENT_TYPE       $content_type;
    fastcgi_param  CONTENT_LENGTH     $content_length;

    # Catalyst requires setting PATH_INFO (instead of SCRIPT_NAME) to $fastcgi_script_name
    fastcgi_param  PATH_INFO          $fastcgi_script_name;
    fastcgi_param  SCRIPT_NAME        /;
    fastcgi_param  REQUEST_URI        $request_uri;
    fastcgi_param  DOCUMENT_URI       $document_uri;
    fastcgi_param  DOCUMENT_ROOT      $document_root;
    fastcgi_param  SERVER_PROTOCOL    $server_protocol;

    fastcgi_param  GATEWAY_INTERFACE  CGI/1.1;
    fastcgi_param  SERVER_SOFTWARE    nginx/$nginx_version;

    fastcgi_param  REMOTE_ADDR        $remote_addr;
    fastcgi_param  REMOTE_PORT        $remote_port;
    fastcgi_param  SERVER_ADDR        $server_addr;
    fastcgi_param  SERVER_PORT        $server_port;
    fastcgi_param  SERVER_NAME        $server_name;
  }
}

```

## EthACK
This application is provided by [EthACK](https://ethack.org/), the Swiss Privacy Basecamp.

## License
BTMview code is released under the GPLv2 license.

Some external stuff are used in this project, and are released under other license:
* [Bootstrap](http://getbootstrap.com/) — [MIT license](http://en.wikipedia.org/wiki/MIT_License)
* [JQuery](https://jquery.com/) — [MIT license](http://en.wikipedia.org/wiki/MIT_License)
