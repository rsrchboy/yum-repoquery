package YUM::RepoQuery::Filelists::Version10::Schema::Result::Packages;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("packages");
__PACKAGE__->add_columns(
  "pkgkey",
  {
    data_type => "INTEGER",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "pkgid",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("pkgkey");


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-09-11 20:02:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2WLtl/S7/ss9JNIbuOovyQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
