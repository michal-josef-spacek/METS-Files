package METS::DjVu;

# Pragmas.
use strict;
use warnings;

# Modules.
use Class::Utils qw(set_params);
use METS::Parse;

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

# Get DjVu files.
sub get_djvu_files {
	my ($self, $mets_data) = @_;

	# Parse METS file.
	my $mets_parser = METS::Parse->new;
	my $mets_hr = $mets_parser->parse($mets_data);

	# Filter DjVu files.
	my @djvu_files;
	if (exists $mets_hr->{'mets:fileSec'}
		&& exists $mets_hr->{'mets:fileSec'}->{'mets:fileGrp'}) {

		foreach my $mets_file_grp_hr (@{$mets_hr->{'mets:fileSec'}
			->{'mets:fileGrp'}}) {

			if ($mets_file_grp_hr->{'USE'} eq 'img') {
				foreach my $file_hr (@{$mets_file_grp_hr->{'mets:file'}}) {
					push @djvu_files, $file_hr->{'mets:FLocat'}->{'xlink:href'};
				}
			}
		}
	}

	return @djvu_files;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

METS::DjVu - Class for METS DjVu manipulation.

=head1 SYNOPSIS

 use METS::DjVu;
 my $obj = METS::DjVu->new;
 my @djvu_files = $obj->get_djvu_files($mets_data);

=head1 METHODS

=over 8

=item C<new()>

 Constructor.

=item C<get_djvu_files($mets_data)>

 Parse METS
 Parse XML data via XML::Simple::XMLin().
 Returns hash reference to structure.

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
 use METS::DjVu;
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
 my $obj = METS::DjVu->new;

 # Get DjVu files.
 my @djvu_files = $obj->get_djvu_files($mets_data);

 # Dump to output.
 p @djvu_files;

 # Output like:
 # TODO

=head1 EXAMPLE2

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use Data::Printer;
 use METS::DjVu;

 # Example METS data.
 my $mets_data <<'END';
 TODO
 END

 # Object.
 my $obj = METS::DjVu->new;

 # Get DjVu files.
 my @djvu_files = $obj->get_djvu_files($mets_data);

 # Dump to output.
 p $djvu_files;

 # Output like:
 # TODO

=head1 DEPENDENCIES

L<Class::Utils>,
L<METS::Parse>.

=head1 REPOSITORY

L<https://github.com/tupinek/METS-DjVu>

=head1 AUTHOR

Michal Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

 © Michal Špaček 2015
 BSD 2-Clause License

=head1 VERSION

0.01

=cut
