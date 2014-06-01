package btmview::Controller::authentication;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

btmview::Controller::authentication - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  $c->response->body('Matched btmview::Controller::authentication in authentication.');
}

sub login :Local :Args(0) {
  my ( $self, $c ) = @_;

  my $username = $c->req->params->{'username'};
  my $password = $c->req->params->{'password'};

  if ($username && $password ) {
    if ($c->authenticate({ username => $username, password => $password })) {
      $c->session->{'user'} = $username;
      $c->response->redirect('/account');
    } else {
      $c->response->body('Hmm nope.');
    }
  } else {
    $c->response->redirect('/');
  }
}

sub logout :Local :Args(0) {
  my ( $self, $c ) = @_;
  $c->logout;
  for( keys %{$c->session} ) {
    delete $c->session->{$_};
  }
  $c->response->redirect('/');
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
