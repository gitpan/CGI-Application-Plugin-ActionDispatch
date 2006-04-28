use Test::More tests => 15;
use strict;

use lib 't/';

# 1
BEGIN { 
	use_ok('CGI::Application');
};

use TestApp;
use CGI;

$ENV{CGI_APP_RETURN_ONLY} = 1;

{
	my $app = TestApp->new();
	$app->query(CGI->new({'test_rm' => 'basic_runmode'}));
	my $output = $app->run();
	like($output, qr/Runmode: basic_runmode/);
}

{
	local $ENV{PATH_INFO} = '';
	my $app = TestApp->new();
	my $output = $app->run();

	like($output, qr{^Content-Type: text/html});
	like($output, qr/Runmode: home/);
}

{
	local $ENV{PATH_INFO} = '';
	my $app = TestApp->new();
	my $output = $app->run();

	like($output, qr{^Content-Type: text/html});
	like($output, qr/Runmode: home/);
}

{
	local $ENV{PATH_INFO} = '/products/books/war_and_peace';
	my $app = TestApp->new();
	my $output = $app->run();

	like($output, qr{^Content-Type: text/html});
	like($output, qr/Runmode: product/);
	like($output, qr/Category: books/);
	like($output, qr/Product: war_and_peace/);
}

{
	local $ENV{PATH_INFO} = '/products/music/rolling_stones';
	my $app = TestApp->new();
	my $output = $app->run();

	like($output, qr{^Content-Type: text/html});
	like($output, qr/Runmode: music/);
	like($output, qr/Product: rolling_stones/);
}

{
	local $ENV{PATH_INFO} = '/products/music/beatles';
	my $app = TestApp->new();
	my $output = $app->run();

	like($output, qr{^Content-Type: text/html});
	like($output, qr/Runmode: beatles/);
}
