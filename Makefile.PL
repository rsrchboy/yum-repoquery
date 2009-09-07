use inc::Module::Install;

name     'YUM-RepoQuery';
all_from 'lib/YUM/RepoQuery.pm';
author   'Chris Weyl <cweyl@alumni.drew.edu>';

# our perl requires
test_requires 'File::Find::Rule';
test_requires 'Test::DBICSchemaLoaderDigest';
test_requires 'Test::More';
test_requires 'ok';

requires 'DBIx::Class';
requires 'File::Find::Rule';
requires 'File::Slurp';
requires 'File::Temp';
requires 'IO::Uncompress::Bunzip2';
requires 'Moose';
requires 'MooseX::AttributeHelpers';
requires 'MooseX::Types::URI';
requires 'URI::Fetch';
requires 'XML::Simple';

# extra author tests 
extra_tests;

auto_install;

WriteAll;

