package YUM::RepoQuery::Schema::Filelists::Version10::Packages;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("packages");
__PACKAGE__->add_columns(
  "pkgkey",
  { data_type => "INTEGER", is_nullable => 0, size => undef },
  "pkgid",
  { data_type => "TEXT", is_nullable => 0, size => undef },
);
__PACKAGE__->set_primary_key("pkgkey");


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-10-19 15:35:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9bYaI4VWfGTT8cDGXuSvYQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
