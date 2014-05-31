use strict;
use warnings;
use Test::More;


use Catalyst::Test 'btmview';
use btmview::Controller::BTMapi;

ok( request('/btmapi')->is_success, 'Request should succeed' );
done_testing();
