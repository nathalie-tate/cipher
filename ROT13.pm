package ROT13;
use strict;
use warnings;
use Exporter qw/import/;

our @EXPORT_OK = qw/rot13/;

sub rot13
{
    my $result = "";
    $result .= tr/A-Za-z/N-ZA-Mn-za-m/r . " " for @_;

    return $result;
}

1;
