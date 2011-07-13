package YUM::RepoQuery::Role::DB;

# ABSTRACT: provide an interface to a specified "type" of yum db

use MooseX::Role::Parameterized;

use MooseX::MarkAsMethods autoclean => 1;
use MooseX::Types::Path::Class ':all';

use Path::Class;

parameter name => (isa => 'Str', required => 1);

role {
    my $p = shift @_;

    my $name  = $p->name;
    my $dbatt = $name . '_db_file';
    my $mdkey = $name . '_db';
    my $class = 'YUM::RepoQuery::Schema::' . ucfirst $name;

    my $precise_class = 'precise_class_' . $name;

    Class::MOP::load_class($class);

    has $name  => (is => 'ro', lazy_build => 1, isa => $class);
    has $dbatt => (is => 'ro', lazy_build => 1, isa => File);

    method "mdinfo_$name" => sub { shift->repomd->{$mdkey} };

    method "precise_class_$name" => sub {

        return 'YUM::RepoQuery::Schema::'
                . ucfirst $name . '::Version'
                . shift->repomd->{$mdkey}->{database_version}
                ;
    };

    requires '_fetch_db';

    method "_build_$dbatt" => sub { shift->_fetch_db($name) };

    method "_build_$name"  => sub {
        my $self = shift @_;

        $self->$precise_class->connect('dbi:SQLite:' . $self->$dbatt);
    };
};

!!42;

__END__

=head1 DESCRIPTION

This is a parameterized role handling accessing/using a specific type of yum
db.

=head1 SEE ALSO

L<YUM::RepoQuery>

=cut
