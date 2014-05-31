#!/usr/bin/env perl

use strict;
use warnings;
use lib "lib";

use btmview;
use namespace::autoclean;
use DateTime;

btmview->model("DB")->schema->deploy;

btmview->model('DB')->resultset('User')->create({
  username   => 'user',
  password   => 'userpassword',
});

1;
