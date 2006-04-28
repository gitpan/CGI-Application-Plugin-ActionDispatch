package WebApp::Cart;

use lib '../lib/';
use base 'WebApp';

sub home {
	my $self = shift;
	
	return "<html><p>Home sweet home. " . $self->query->path_info() . "</p></html>";
}

sub delete : Regex('cart/delete/(\d+)') {
	my $self = shift;

	my $id = $self->snippets();
	return "<html><p>Deleting $id from your shopping cart.</p></html>";
}

sub product : Path('product/') {
	my $self = shift;

	my($category, $product) = $self->snippets();
	return "<html><p>Viewing product $product in category $category.</p></html>";
}

1;
