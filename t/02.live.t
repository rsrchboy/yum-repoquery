use Test::More;

plan skip_all => 'Must set YRQ_LIVE_TESTS for live YUM::RepoQuery tests'
    unless exists $ENV{YRQ_LIVE_TESTS};

plan tests => 23;

use YUM::RepoQuery;

my $repo = YUM::RepoQuery->new(
    id  => 'F-9', 
    uri => 'http://archives.fedoraproject.org/pub/archive/fedora/linux/updates/9/SRPMS.newkey/',
);

isa_ok($repo, 'YUM::RepoQuery');

like($repo->repo_dir, qr|^/var/tmp/yum-|, 'repo_dir looks good');

for my $type (qw( primary other filelists )) {

    my $primary = $repo->primary;

    isa_ok($primary, 'YUM::RepoQuery::Schema::Primary::Version10');
    isa_ok($primary, 'YUM::RepoQuery::Schema::Primary');
    isa_ok($primary, 'YUM::RepoQuery::Schema');

    my $count = $primary->resultset('DbInfo')->count;
    is($count, 1, 'correct num of rows in db_info');

    my $row = $primary->resultset('DbInfo')->first;
    isa_ok($row, 'DBIx::Class::Row');
    is($row->dbversion, 10, 'db version is 10');
}


is($repo->package_count > 0, 1, 'has a positive package count');
is($repo->has_package('perl-Moose') == 1, 1, 'repo has perl-Moose');

my $pkg = $repo->get_package('perl-Moose');

isa_ok($pkg, 'DBIx::Class::Row');


