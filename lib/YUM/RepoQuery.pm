#############################################################################
#
# Query YUM repositories for package information. 
#
# Detailed documentation on this package can be found at the end of this
# file.
#
# Copyright (c) Chris Weyl <cweyl@alumni.drew.edu> 2008.
#
#############################################################################

package YUM::RepoQuery;

use Moose;
use MooseX::AttributeHelpers;

our $VERSION = '0.0.3';

# FIXME -- should be a URI type
has uri => (isa => 'Str', is  => 'ro', required => 1);
has id  => (is => 'ro', isa => 'Str', required => 1);

has packages => (
    metaclass => 'Collection::Hash',
    is        => 'ro',
    isa       => 'HashRef[HashRef]',
    lazy      => 1,

    provides => {
        get   => 'package_summary',
        count => 'num_packages',
    },

    # fetch and parse
    default => sub {  
        my $self = shift @_;

        my @fields = 
            qw/epoch ver rel arch summary url license group buildtime/;

        my $split = sub {
            my @parts = split /:/, shift @_; 
            my $name = shift @parts;
            return ($name => { map { $_ => shift @parts } @fields });
        };

        my $cmd = 'repoquery -a --repofrompath=cu'
            . $self->id . ',' . $self->uri
            . ' --repoid=yr' . $self->id 
            . ' --archlist=i386,src'
            . ' --qf "%{name}:%{epoch}:%{ver}:%{rel}:%{arch}:%{summary}'
            . ':%{url}:%{license}:%{group}:%{buildtime}"'
            #. ' --qf "%{name}:%{epoch}:%{ver}:%{rel}:%{arch}"'
            #. ' --qf "%{name}:%{ver}:%{rel}:%{arch}"'
            ;

        my @output = `$cmd`;

        # get rid of the 'Adding repo...'
        shift @output;

        my %pkgs = map { chomp; $split->($_) } @output;

        return \%pkgs;
    },
);

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

YUM::RepoQuery - Query a YUM repository for package information 


=head1 SYNOPSIS

    use YUM::RepoQuery;

    my $repo = YUM::RepoQuery->new(
        # short tag to id the repo with
        id  => 'f9-updates-src'
        # uri to the repository
        uri => 'ftp://mirrors.kernel.org/fedora/updates/9/SRPMS',
    );


=head1 DESCRIPTION

YUM::RepoQuery takes the URI to a package repository with YUM metadata, and
allows one to query what packages, and versions of those packages, are
available in that repo.

Right now we use the 'repoquery' command included with the yum package to do
most of the hard work -- that is, to pull down and parse the YUM metadata.

WARNING: This is a very early, primitive package.  "Release early, release
often", right? :)


=head1 INTERFACE 

=head2 Attributes 

=head3 id

Required.  A short tag used to id this particular repo; mainly used when
talking to repoquery.

=head3 uri

Required.  The URI of the repository we want to query.

=head2 Repository Data

=head3 package_summary

Get a hashref referring to a specific package's info.  e.g.

    my $data = $repo->package('Moose');
    # $data is
    # {
    #   epoch => undef,
    #   ver   => 0.57,
    #   rel   => '1.fc10',
    #   arch  => 'noarch',
    #   url   => 'http://search.cpan.org/dist/Moose',
    #   ...
    # }

=head3 num_packages

Returns the count of all packages in this repository.


=head1 CONFIGURATION AND ENVIRONMENT

YUM::RepoQuery requires no configuration files or environment variables.


=head1 DEPENDENCIES

YUM::RepoQuery requires Moose, MooseX::AttributeHelpers, and the external
executable 'repoquery'.


=head1 INCOMPATIBILITIES

None known.


=head1 BUGS AND LIMITATIONS

No bugs have been reported.

There's a lot of room for improvement here; a better set of accessors + tests
would certainly be nice.

Please report any bugs or feature requests to
C<bug-yum-repoquery@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.


=head1 AUTHOR

Chris Weyl  C<< <cweyl@alumni.drew.edu> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2008, Chris Weyl C<< <cweyl@alumni.drew.edu> >>.

This library is free software; you can redistribute it and/or modify it under
the terms of the GNU Lesser General Public License as published by the Free 
Software Foundation; either version 2.1 of the License, or (at your option) 
any later version.

This library is distributed in the hope that it will be useful, but WITHOUT 
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
OR A PARTICULAR PURPOSE.

See the GNU Lesser General Public License for more details.  

You should have received a copy of the GNU Lesser General Public License 
along with this library; if not, write to the 

    Free Software Foundation, Inc., 
    59 Temple Place, Suite 330, 
    Boston, MA  02111-1307 USA


