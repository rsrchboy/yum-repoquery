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

package YUM::RepoQuery::Schema::Filelists;

use base 'YUM::RepoQuery::Schema';

# dinky little class that we can use for typeconstraints.


1;

__END__

=head1 NAME

YUM::RepoQuery::Schema::Filelists - Dinky base class.


=head1 SYNOPSIS

See L<YUM::RepoQuery>


=head1 DESCRIPTION

This is a little base class that all our versioned Filelists schemas can descend
from.  You shouldn't ever use this, as it doesn't actually do anything.

=head1 SEE ALSO

L<YUM::RepoQuery>

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


