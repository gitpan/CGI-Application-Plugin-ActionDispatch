use Test::More tests => 7;
use strict;

use lib 't/';

BEGIN { 
	use_ok('CGI::Application');
};

use TestAppPath;
use CGI;

$ENV{CGI_APP_RETURN_ONLY} = 1;

{
	local $ENV{PATH_INFO} = '/products/music/rolling_stones/this/is/really/long/';
	my $app = TestAppPath->new();
	my $output = $app->run();

	like($output, qr{^Content-Type: text/html});
	like($output, qr/Runmode: test_rm/);
	like($output, qr/Args: this is really long/);
}

{
	local $ENV{PATH_INFO} = '/products/music/beatles/this/is/really/long/';
	my $app = TestAppPath->new();
	my $output = $app->run();

	like($output, qr{^Content-Type: text/html});
	like($output, qr/Runmode: test_rm_partial/);
	like($output, qr/Args: this is really long/);
}
