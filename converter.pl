#!/usr/bin/env perl
use strict;
use warnings;
use feature qw/say/;

use FindBin qw/$Bin/;
use lib "$Bin";

my @ciphertext;
my @alpha = ('a'..'z');

while(<>)
{
    chomp;
    push @ciphertext, $_;
}

for my $text (@ciphertext)
{
  print $alpha[$_] for split(/[^\d]+/, $text);
  print "\n";
}
