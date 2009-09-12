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
use MooseX::AlwaysCoerce;
use MooseX::Types::URI         ':all';
use MooseX::Types::Path::Class ':all';

our $VERSION = '0.1.1';

use English '-no_match_vars';

use File::Find::Rule;
use File::Slurp;
use File::stat;
use File::Temp qw{ tempdir };
use IO::Uncompress::Bunzip2 qw{ bunzip2 };
use Path::Class qw{ file dir };
use URI::Fetch;
use XML::Simple;

use namespace::clean -except => 'meta';

# FIXME -- should be a URI type
has id  => (is => 'ro', isa => 'Str', required => 1);

has uri => (isa => Uri, is  => 'ro', required => 1, coerce => 1);

has repo_dir  => (is => 'ro', isa => Dir, lazy_build => 1, coerce => 1);
has cache_dir => (is => 'ro', isa => Dir, lazy_build => 1, coerce => 1);

sub _build_cache_dir {
    my $self = shift @_;

    my $name = getpwuid($EUID);

    # look for an existing one
    my @dirs = File::Find::Rule
        ->directory
        ->name("yum-$name-*")
        ->maxdepth(1)
        ->in('/var/tmp')
        ;
    
    # find any, return the last one else create it
    return pop @dirs if @dirs > 0;
    return tempdir "yum-$name-XXXXXX", DIR => '/var/tmp';
}

sub _build_repo_dir {
    my $self = shift @_;

    my $repo_dir = dir $self->cache_dir, $self->id;
    $repo_dir->mkpath unless $repo_dir->stat;

    return $repo_dir;
}

has repomd => (
    traits => [ 'Hash' ],
    is  => 'ro',
    isa => 'HashRef',
    lazy_build => 1,
);

sub _build_repomd {
    my $self = shift @_;

    # fetch and write repomd.xml...
    my $xmlstr = $self->_fetch($self->uri . 'repodata/repomd.xml');
    write_file file($self->repo_dir, 'repomd.xml'), { atomic => 1}, $xmlstr;

    # now, convert to a hashref and return the interesting bits...
    return XMLin($xmlstr, KeyAttr => 'type')->{data};
}

has primary   => (is => 'ro', lazy_build => 1, isa => 'YUM::RepoQuery::Schema::Primary');
has other     => (is => 'ro', lazy_build => 1, isa => 'YUM::RepoQuery::Schema::Other');
has filelists => (is => 'ro', lazy_build => 1, isa => 'YUM::RepoQuery::Schema::Filelists');

sub _build_primary   { shift->_fetch_db('primary') }
sub _build_other     { shift->_fetch_db('other') }
sub _build_filelists { shift->_fetch_db('filelists') }



# note we do this as a hash as it makes 'exists' easier :-)
has _packages => (
    metaclass  => 'Collection::Hash',
    is         => 'ro',
    isa        => 'HashRef[Str]',
    lazy_build => 1,

    provides => {
        count  => 'package_count',
        exists => 'has_package',
        keys   => 'packages',
    },
);

sub _build__packages {
    my $self = shift @_;

    my %pkgs = map { $_ => 1 }
        $self->primary->resultset('Packages')->get_column('name')->all
        ;

    return \%pkgs;
}

sub get_package { 
    my $self = shift @_;
    my $name = shift @_ || confess 'Must provide package name!';

    return $self
        ->primary
        ->resultset('Packages')
        ->search({ name => $name })
        ->first
        ;
}

sub _fetch_db {
    my $self = shift @_;
    my $name = shift @_ || confess "Must pass the db data name to fetch";

    # we could check to make sure we know how to handle it, but for now... 
    my $mdkey  = $name . '_db';
    my $mdinfo = $self->repomd->{$mdkey} 
        or confess "repomd doesn't contain any info about $mdkey";

    #my $db_loc_uri = $self->uri . '/' . $mdinfo->{location}->{href};
    my $db_loc_uri = $self->uri . $mdinfo->{location}->{href};
    my $db_fn = file $self->repo_dir, "$name.sqlite";

    # see if we have a cached copy; if so, if it's new enough
    #if (! $db_fn->stat || $db_fn->stat->mtime != $mdinfo->{timestamp}) {
    if (!$db_fn->stat || $db_fn->stat->mtime < $mdinfo->{timestamp}) {

        # fetch the file
        my $db_cache = $self->_fetch($db_loc_uri);

        # and write out, bunzip2ing as we go...
        bunzip2 \$db_cache => $db_fn
            or confess "bunzip2 error: $IO::Uncompress::Bzip2::Bunzip2error";
    }

    # now, figure out what class to load and create our schema object...
    our $class = 'YUM::RepoQuery::Schema::' 
        . ucfirst $name . '::Version' . $mdinfo->{database_version};

    eval "use $class";
    confess "Cannot use $class: $@" if $@;

    return $class->connect("dbi:SQLite:$db_fn");
}

sub _fetch {    
    my $self = shift @_;
    my $uri  = shift @_ || confess 'Must pass a uri';

    my $rsp = URI::Fetch->fetch($uri);

    # FIXME could probably do with some more error checking here
    confess(URI::Fetch->errstr) unless $rsp;

    return $rsp->content;
}

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

WARNING: This is a very early, primitive package.  "Release early, release
often", right? :)

=head1 INTERFACE 

"Release Early, Release Often"

There's a bunch more that we can do here (not the least of which is
documentation!).  As I get time, I'll be updating and adding more; please feel
free to drop a line with patches / requests either at my email or (preferably)
at this module's rt tracker address (L<bug-yum-repoquery@rt.cpan.org>).

=head2 METHODS

=over 4

=item B<new()>

Standard constructor.  Takes a number of arguments, two of which are
required:

=over 4 

=item I<id>

(Required) The id one refers to this repo as.  Used mainly in looking for
existing yum cache directories under /var/tmp/.

=item I<uri>

(Required) The URI of the repository.

=back

=item B<primary>

The DBIx::Class schema corresponding to this repository's primary.sqlite.

=item B<other>

The DBIx::Class schema corresponding to this repository's other.sqlite.

=item B<filelists>

The DBIx::Class schema corresponding to this repository's filelists.sqlite.

=item B<packages>

An array of all packages in this repo.

=item B<package_count>

Returns the count of all packages in this repository.

=item B<has_package (str)>

When called with a package name, returns true if that package exists in this
repository.

=item B<get_package (str)>

Given a package name, returns the row object corresponding to it.

=back 

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


=head1 LICENSE AND COPYRIGHT

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


# vim:textwidth=96:
