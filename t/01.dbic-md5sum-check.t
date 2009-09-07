#!/usr/bin/perl

# check to make sure the md5sums on our generated schema files are intact...

use strict;
use warnings;

use Test::More;

use File::Find::Rule;
use FindBin;
use Test::DBICSchemaLoaderDigest;

my $base = "$FindBin::Bin/../lib/YUM/RepoQuery/Schema";

my @to_test = File::Find::Rule
    ->file
    ->name('*.pm')
    ->in("$base/Primary", "$base/Other", "$base/Filelists")
    ;

# ok, now that we have found our files, let the planning begin!

plan tests => scalar @to_test;

for my $file (@to_test) {

    ### testing md5 for: $file
    test_dbic_schema_loader_digest($file);
}

# fin...
