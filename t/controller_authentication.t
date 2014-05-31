use strict;
use warnings;
use Test::More;


use Catalyst::Test 'btmview';
use btmview::Controller::authentication;

ok( request('/authentication')->is_success, 'Request should succeed' );
done_testing();
