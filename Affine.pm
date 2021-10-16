package Affine;
use strict;
use warnings;
use List::Util qw/first/;
use Math::Prime::Util qw/gcd/;
use Math::ModInt qw/mod/;
use Exporter qw/import/;

our @EXPORT_OK = qw/affine/;

# E(x) = (ax+b) mod m
# D(x) = a**-1 (x-b) mod m
#
# Where m = 26 (number of characters)
#       a = key
#       b = shift
#       x = letter index
#       a**-1 is the modular mulitiplicitive inverse
#
#       a and m must be coprime. with m = 26, there are 12 acceptable values for
#       a: 1, 3, 5, 7, 9, 11, 15, 17, 19, 21, 23, 25

sub affine
{
    my $op = shift; # e or d
    my $a = shift;
    my $b = shift;
    my $m = 26;
    my $line = lc shift;

    my @words = split / /, $line;

    my $result = "";

    die "a and m must be coprime!" unless gcd($a, 26) == 1;

    my %alpha;
    my %num;

    for my $i (0..25)
    {
        $alpha{chr($i + ord('a'))} = $i;
        $num{$i} = chr($i + ord('a'));
    }

    if ($op eq 'e')
    {
        for my $word(@words)
        {
            $result .= $num{enc($a, $b, $alpha{$_}, 26)} for split //, $word;
            $result .= " ";
        }
    }

    elsif ($op eq 'd')
    {
        for my $word (@words)
        {
            $result .= $num{dec($a, $b, $alpha{$_}, 26)} for split //, $word;
            $result .= " ";
        }
    }

    else
    {
        die "Invald operation";
    }

    return $result;
}

sub enc
{
    my ($a, $b, $x, $m) = @_;

    return ($a * $x + $b) % $m;
}

sub dec
{
    my ($a, $b, $x, $m) = @_;

    my $mod = mod($a, $m);

    return ($mod->inverse * ($x - $b))->residue;
}

1;
