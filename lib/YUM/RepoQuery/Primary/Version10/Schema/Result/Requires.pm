package YUM::RepoQuery::Primary::Version10::Schema::Result::Requires;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("requires");
__PACKAGE__->add_columns(
  "name",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "flags",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "epoch",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "version",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "release",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "pkgkey",
  {
    data_type => "INTEGER",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "pre",
  {
    data_type => "BOOLEAN",
    default_value => "FALSE",
    is_nullable => 1,
    size => undef,
  },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-09-11 19:59:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:lI8wrha6KV2sVT4yvr70gA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
