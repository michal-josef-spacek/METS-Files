# Pragmas.
use strict;
use warnings;

# Modules.
use inc::Module::Install;

# Definition.
abstract 'Create DjVu files from METS specification.';
author 'Michal Spacek <skim@cpan.org>';
author_requires 'English' => 0;
author_requires 'File::Object' => 0.05;
author_requires 'Test::More' => 0;
author_requires 'Test::NoWarnings' => 0;
author_requires 'Test::Pod' => 0;
author_requires 'Test::Pod::Coverage' => 0;
license 'bsd';
name 'METS-DjVu';
readme_from 'DjVu.pm';
recursive_author_tests('xt');
#requires 'Class::Utils' => 0.05;
#requires 'Error::Pure' => 0.16;
#requires 'perl' => '5.6.2';
resources 'bugtracker' => 'https://rt.cpan.org/Public/Dist/Display.html'.
	'?Name=METS-DjVu';
resources 'homepage' => 'https://github.com/tupinek/METS-DjVu';
resources 'repository' => 'git://github.com/tupinek/METS-DjVu';
test_requires 'Test::More' => 0;
test_requires 'Test::NoWarnings' => 0;
tests_recursive;
version '0.01';

# Run.
WriteAll();
