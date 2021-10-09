#!/usr/bin/perl

use strict;
use warnings;
use feature qw/say/;

say shift =~ tr/A-Za-z/N-ZA-Mn-za-m/r;
