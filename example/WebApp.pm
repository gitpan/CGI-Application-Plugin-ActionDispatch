package WebApp;

use lib '../lib/';
use base qw/CGI::Application/;
use CGI::Application::Plugin::ActionDispatch;


sub setup {
	my $self = shift;
	$self->start_mode('home');
	$self->mode_param('rm');
	$self->run_modes( 
		home => 'home',
	);
}

sub add : Regex('cart/add/(\d+)') {
	my $self = shift;

	my $id = $self->snippets();
	return "<html><p>Add $id to your shopping cart</p></html>";
}



1;
