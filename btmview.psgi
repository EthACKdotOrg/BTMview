use strict;
use warnings;

use btmview;

my $app = btmview->apply_default_middlewares(btmview->psgi_app);
$app;

