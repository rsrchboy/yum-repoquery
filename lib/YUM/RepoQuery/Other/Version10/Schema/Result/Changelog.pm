package YUM::RepoQuery::Other::Version10::Schema::Result::Changelog;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("changelog");
__PACKAGE__->add_columns(
  "pkgkey",
  {
    data_type => "INTEGER",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "author",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "date",
  {
    data_type => "INTEGER",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "changelog",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-09-11 20:02:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gOj3jwFo1GDjWd+Dp3OGKQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
