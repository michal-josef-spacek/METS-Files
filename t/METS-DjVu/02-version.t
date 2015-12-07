# Pragmas.
use strict;
use warnings;

# Modules.
use METS::DjVu;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($METS::DjVu::VERSION, 0.01, 'Version.');
