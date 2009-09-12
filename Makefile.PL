use inc::Module::Install;

name     'YUM-RepoQuery';
all_from 'lib/YUM/RepoQuery.pm';
author   'Chris Weyl <cweyl@alumni.drew.edu>';

requires 'namespace::clean' => '0.11';

requires 'Moose';
requires 'MooseX::AttributeHelpers' => '0.21';
requires 'MooseX::Types::Path::Class';
requires 'MooseX::Types::URI';

requires 'DBIx::Class';
requires 'File::Find::Rule';
requires 'File::Slurp';
requires 'File::Temp';
requires 'IO::Uncompress::Bunzip2';
requires 'Path::Class' => '0.16';
requires 'URI::Fetch';
requires 'XML::Simple';

test_requires 'Test::DBICSchemaLoaderDigest';
test_requires 'Test::More';
test_requires 'ok';

githubmeta;
auto_provides;
auto_install;
extra_tests;

WriteAll;

