package YUM::RepoQuery::Schema::Filelists::Version10::Filelist;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("filelist");
__PACKAGE__->add_columns(
  "pkgkey",
  { data_type => "INTEGER", is_nullable => 0, size => undef },
  "dirname",
  { data_type => "TEXT", is_nullable => 0, size => undef },
  "filenames",
  { data_type => "TEXT", is_nullable => 0, size => undef },
  "filetypes",
  { data_type => "TEXT", is_nullable => 0, size => undef },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-10-19 15:35:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:211xYQ4F4i5bzle5VCtaIA


__PACKAGE__->belongs_to(
    'package',
    'YUM::RepoQuery::Schema::Filelists::Version10::Packages',
    { 'foreign.pkgkey' => 'self.pkgkey' },
);

1;
