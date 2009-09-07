package YUM::RepoQuery::Schema::Other::Version10::Changelog;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("changelog");
__PACKAGE__->add_columns(
  "pkgkey",
  { data_type => "INTEGER", is_nullable => 0, size => undef },
  "author",
  { data_type => "TEXT", is_nullable => 0, size => undef },
  "date",
  { data_type => "INTEGER", is_nullable => 0, size => undef },
  "changelog",
  { data_type => "TEXT", is_nullable => 0, size => undef },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-10-19 15:31:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:B7eW+ukTSNEcbIFEzKG9wA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
