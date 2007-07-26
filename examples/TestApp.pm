package TestApp;

use base 'CGI::Application';
use lib '../lib';
use CGI::Application::Plugin::ActionDispatch;

sub product : Regex('^/products/books/war_and_peace/(\d+)/')  {
  my $self = shift;
  my $page_num = $self->action_args();
  return "Runmode: product\nCategory: books\nProduct: war_and_peace\nArgs: $page_num\n";
}

sub home : Default {
  return "Runmode: home\n";
}

sub test : Runmode {
  return "Runmode: test\n";
}

1;
