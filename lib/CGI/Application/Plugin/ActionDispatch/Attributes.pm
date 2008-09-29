package CGI::Application::Plugin::ActionDispatch::Attributes;

use attributes;
use strict;
use Data::Dumper;

our $VERSION = '0.1';

my @attributes;
my %attr_handlers;

my $init = 1;

# MODIFY_CODE_ATTRIBUTES needs to be in the inheritance tree.
push @CGI::Application::ISA, 'CGI::Application::Plugin::ActionDispatch::Attributes'
	unless grep /^CGI::Application::Plugin::ActionDispatch::Attributes$/, @CGI::Application::ISA;

sub MODIFY_CODE_ATTRIBUTES {
	my($class, $code, @attrs) = @_;

	foreach (@attrs) {
		# Parse the attribute string ex: Regex('^/foo/bar/(\d+)/').
		my($method, $params) = /^([a-z_]\w*)(?:[(](.*)[)])?$/is;
		$params =~ s/(^'|'$)//g if defined $params;

		# Attribute definition.
		if($method eq 'ATTR') {
			$attr_handlers{$code} = $params
		} 
		# Is a custom attribute.
		else {
			my $handler = $class->can($method);
			next unless $handler;
			push(@attributes, [ $class, $method, $code, $params ] );
		}
	}

	return ();
}

sub init {
	return unless $init; # Initialize only once
	
	foreach my $attr (@attributes) {
		my $class	= $attr->[0];
		my $method	= $attr->[1];
		
		# calls:  class->method( code, method, params );
		$class->$method( $attr->[2], $attr->[1], $attr->[3]);
	}
	$init = 0;
}


1;
__END__
=head1 NAME

CGI::Application::Plugin::ActionDispatch::Attributes - Hidden attribute support for CGI::Application

=head1 SYNOPSIS
	
  use CGI::Application::Plugin::ActionDispatch::Attributes;

  sub CGI::Application::Protected : ATTR {
	my( $package, $referent, $attr, $data ) = @_;
	...
  }
  CGI::Application::Plugin::ActionDispatch::Attributes::init();

  sub my_method Protected {
	...
  }

=head1 DESCRIPTION

This module will add attribute support into CGI::Application.  It will
also not break mod_perl.

T
 
=head1 SEE ALSO

=head1 AUTHOR

Jason Yates, E<lt>jaywhy@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006-2008 by Jason Yates

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.


=cut
