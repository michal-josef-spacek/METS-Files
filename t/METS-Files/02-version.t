# Pragmas.
use strict;
use warnings;

# Modules.
use METS::Files;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($METS::Files::VERSION, 0.01, 'Version.');
