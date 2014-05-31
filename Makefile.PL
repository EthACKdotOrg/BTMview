#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install 1.02;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'btmview';
all_from 'lib/btmview.pm';

requires 'Catalyst::Runtime' => '5.90062';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Authentication::Realm::SimpleDB';
requires 'Catalyst::View::XML::Simple';
requires 'Catalyst::View::TT';
requires 'Catalyst::View::JSON';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
requires 'DateTime';
requires 'RPC::XML';
requires 'Scalar::Util';
requires 'MIME::Base64';
requires 'DBIx::Class::PassphraseColumn';
test_requires 'Test::More' => '0.88';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
