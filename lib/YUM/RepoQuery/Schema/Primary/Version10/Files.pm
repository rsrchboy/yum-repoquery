package YUM::RepoQuery::Schema::Primary::Version10::Files;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("files");
__PACKAGE__->add_columns(
  "name",
  { data_type => "TEXT", is_nullable => 0, size => undef },
  "type",
  { data_type => "TEXT", is_nullable => 0, size => undef },
  "pkgkey",
  { data_type => "INTEGER", is_nullable => 0, size => undef },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-10-19 14:13:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5e4s6wyBIdn9m9ttKSvEew


# You can replace this text with custom content, and it will be preserved on regeneration
1;
