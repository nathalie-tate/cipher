#!/usr/bin/env perl
#let less sort them out
use strict;
use warnings;
use feature qw/say/;

use FindBin qw/$Bin/;
use lib "$Bin";

use ROT13 qw/rot13/;
use Affine qw/affine/; 
use Caesar qw/caesar/;

my $words = "/usr/share/dict/words";

my %dict;

if ($words)
{
    open FH, "<$words";
    while(<FH>)
    {
        chomp;
        $dict{lc $_}++;
    }
}

close FH;

my @ciphertext;

while(<>)
{
    chomp;
    push @ciphertext, $_;
}

for my $text (@ciphertext)
{
    say "CIPHER TEXT: $text";

    say "AFFINE";
    for my $a (1, 3, 5, 7, 9, 11, 15, 17, 19, 21, 23, 25)
    {
        for my $b (0..25)
        {
            my $result = affine("d", $a, $b, $text);
            my $flag = "";
            for (split / /, $result)
            {
                $flag = "\t" . "*" x 20 if exists $dict{lc $_} && length $_ > 2;
            }
            say "\$a=$a\t\$b=$b\t" . $result . $flag;
        }
    }

    say "CAESAR";
    for my $n (1..25)
    {
        my $result = caesar($n, $text);
        my $flag = "";
        for (split / /, $result)
        {
            $flag = "\t" . "*" x 20 if exists $dict{lc $_} && length $_ > 2;
        }
        say "\$n=$n\t" . $result . $flag;
    }
}
