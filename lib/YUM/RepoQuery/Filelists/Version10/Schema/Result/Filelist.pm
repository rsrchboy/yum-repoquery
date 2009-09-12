package YUM::RepoQuery::Filelists::Version10::Schema::Result::Filelist;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("filelist");
__PACKAGE__->add_columns(
  "pkgkey",
  {
    data_type => "INTEGER",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "dirname",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "filenames",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "filetypes",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-09-11 20:02:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6pgzIet6vn2pglvBKeO75g


# You can replace this text with custom content, and it will be preserved on regeneration
1;
