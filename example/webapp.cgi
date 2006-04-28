#!/usr/bin/perl

use strict;
use lib qw( ../lib/ .);

# Testing on command line.
 $ENV{PATH_INFO} = $ARGV[0];
use WebApp::Cart;

my $webapp = WebApp::Cart->new();
$webapp->run();
