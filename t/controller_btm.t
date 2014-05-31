use strict;
use warnings;
use Test::More;


use Catalyst::Test 'btmview';
use btmview::Controller::btm;

ok( request('/btm')->is_success, 'Request should succeed' );
done_testing();
