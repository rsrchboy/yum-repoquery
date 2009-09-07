package YUM::RepoQuery::Schema::Primary::Version10::Obsoletes;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("obsoletes");
__PACKAGE__->add_columns(
  "name",
  { data_type => "TEXT", is_nullable => 0, size => undef },
  "flags",
  { data_type => "TEXT", is_nullable => 0, size => undef },
  "epoch",
  { data_type => "TEXT", is_nullable => 0, size => undef },
  "version",
  { data_type => "TEXT", is_nullable => 0, size => undef },
  "release",
  { data_type => "TEXT", is_nullable => 0, size => undef },
  "pkgkey",
  { data_type => "INTEGER", is_nullable => 0, size => undef },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-10-19 14:13:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zjUQK52+ENYc0dvvbwIvfg

__PACKAGE__->belongs_to(
    'package',
    'YUM::RepoQuery::Schema::Primary::Version10::Packages',
    { 'foreign.pkgkey' => 'self.pkgkey' },
);


1;
