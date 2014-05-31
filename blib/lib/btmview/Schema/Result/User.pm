use utf8;
package btmview::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

btmview::Schema::Result::User

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::PassphraseColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "PassphraseColumn");

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 username

  data_type: 'varchar'
  is_nullable: 0

=head2 password

  data_type: 'varchar'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "username",
  { data_type => "varchar", is_nullable => 0 },
  "password",
  { data_type => "varchar", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</username>

=back

=cut

__PACKAGE__->set_primary_key("username");


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-05-28 20:58:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:lcNhHv/PdWxF6Xa1stwIEg

__PACKAGE__->add_columns(
  'password' => {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
    passphrase => 'rfc2307',
    passphrase_class => 'SaltedDigest',
    passphrase_check_method => 'check_password',
    passphrase_args => {
      salt_random => 256,
      algorithm => 'SHA-1',
    },
  },
);


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
