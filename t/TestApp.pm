package TestApp;

use base 'CGI::Application';
use CGI::Application::Plugin::ActionDispatch;

@TestApp::ISA = qw(CGI::Application);

sub setup {
	my $self = shift;
	$self->start_mode('home');
	$self->mode_param('test_rm');
	$self->run_modes( 
		home => 'home',
		basic_runmode => 'basic_runmode'
	);
}

sub home {
	my $self = shift;
	return "Runmode: home\n";
}

sub basic_runmode {
	my $self = shift;
	return "Runmode: basic_runmode\n";
}

sub product : Path('products/') {
	my $self = shift;

	my($category, $product) = $self->snippets();
	return "Runmode: product\nCategory: $category\nProduct: $product\n";
}

sub music : Path('products/music/') {
	my $self = shift;
	my $product = $self->snippets();
	return "Runmode: music\nProduct: $product\n";
}

sub beatles : Regex('^/products/music/beatles\/?')  {
	my $self = shift;
	return "Runmode: beatles\n";
}
