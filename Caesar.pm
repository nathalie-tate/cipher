package Caesar;
use strict;
use warnings;
use Exporter qw/import/;
use List::Util qw/first/;

our @EXPORT_OK = qw/caesar/;

sub caesar
{
    my $n = shift;
    my $line = shift;

    my @words = split / /, $line;

    my @alpha = 'a'..'z';

    my $result = "";

    for my $word (@words)
    {
        for my $letter(split //, $word)
        {
            my $index = first { $alpha[$_] eq lc($letter) } 0..$#alpha;

            $index += $n;
            $index -= 26 if $index > 25;
            $index += 26 if $index < 0;

            if (lc($letter) eq $letter)
            {
                $result .= $alpha[$index];
            }
            else
            {
                $result .= uc($alpha[$index]);
            }
        }

        $result .= " ";
    }

    return $result;
}

1;
