use inc::Module::Install;

name     'YUM-RepoQuery';
all_from 'lib/YUM/RepoQuery.pm';
author   'Chris Weyl <cweyl@alumni.drew.edu>';

# our perl requires
test_requires 'Test::More';

requires       'Moose';
requires       'MooseX::AttributeHelpers';

# non-perl requires
requires_external_bin 'repoquery';

# extra author tests
extra_tests;

auto_install;

WriteAll;

