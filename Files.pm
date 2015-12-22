package METS::Files;

# Pragmas.
use strict;
use warnings;

# Modules.
use Class::Utils qw(set_params);
use METS::Parse::Simple;

# Version.
our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Process parameters.
	set_params($self, @params);

	return $self;
}

# Get img files.
sub get_img_files {
	my ($self, $mets_data) = @_;

	# Parse METS file.
	my $mets_hr = METS::Parse::Simple->new->parse($mets_data);

	# Filter img files.
	return $self->_get_files($mets_hr, 'img');
}

# Get common type.
sub _get_files {
	my ($self, $mets_hr, $type) = @_;
	my @files;
	if (exists $mets_hr->{'mets:fileSec'}
		&& exists $mets_hr->{'mets:fileSec'}->{'mets:fileGrp'}) {

		foreach my $mets_file_grp_hr (@{$mets_hr->{'mets:fileSec'}
			->{'mets:fileGrp'}}) {

			if ($mets_file_grp_hr->{'USE'} eq $type) {
				foreach my $file_hr (@{$mets_file_grp_hr->{'mets:file'}}) {
					push @files, $file_hr->{'mets:FLocat'}->{'xlink:href'};
				}
			}
		}
	}
	return @files;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

METS::Files - Class for METS files manipulation.

=head1 SYNOPSIS

 use METS::Files;
 my $obj = METS::Files->new;
 my @img_files = $obj->get_img_files($mets_data);

=head1 METHODS

=over 8

=item C<new()>

 Constructor.

=item C<get_img_files($mets_data)>

 Get img files.
 Returns array with files.

=back

=head1 ERRORS

 new():
         From Class::Utils::set_params():
                 Unknown parameter '%s'.

=head1 EXAMPLE1

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use Data::Printer;
 use METS::Files;
 use Perl6::Slurp qw(slurp);

 # Arguments.
 if (@ARGV < 1) {
         print STDERR "Usage: $0 $mets_file\n";
         exit 1;
 }
 my $mets_file = $ARGV[0];

 # Get mets data.
 my $mets_data = slurp($mets_file);

 # Object.
 my $obj = METS::Files->new;

 # Get img files.
 my @img_files = $obj->get_img_files($mets_data);

 # Dump to output.
 p @img_files;

 # Output like:
 # TODO

=head1 EXAMPLE2

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use Data::Printer;
 use METS::Files;

 # Example METS data.
 my $mets_data <<'END';
 TODO
 END

 # Object.
 my $obj = METS::Files->new;

 # Get img files.
 my @img_files = $obj->get_img_files($mets_data);

 # Dump to output.
 p @img_files;

 # Output like:
 # TODO

=head1 DEPENDENCIES

L<Class::Utils>,
L<METS::Parse::Simple>.

=head1 REPOSITORY

L<https://github.com/tupinek/METS-Files>

=head1 AUTHOR

Michal Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

 © Michal Špaček 2015
 BSD 2-Clause License

=head1 VERSION

0.01

=cut
