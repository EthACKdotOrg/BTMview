package btmview::Controller::account;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

btmview::Controller::account - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

sub auto :Private {
  my ( $self, $c ) = @_;
  if (!$c->user_exists) {
    $c->response->redirect('/');
    0;
  }
  1;
}

=head2 index

=cut

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;
}




=encoding utf8

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
