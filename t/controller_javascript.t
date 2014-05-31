use strict;
use warnings;
use Test::More;


use Catalyst::Test 'btmview';
use btmview::Controller::javascript;

ok( request('/javascript')->is_success, 'Request should succeed' );
done_testing();
