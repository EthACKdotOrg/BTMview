package btmview::Controller::account;
use Moose;
use namespace::autoclean;
use Data::Password::Entropy;

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

sub update :Local :Args(1) {
  my ( $self, $c, $action ) = @_;
  if ($action eq 'password') {
    my $current = $c->req->params->{'currentPassword'};
    my $newpass = $c->req->params->{'newPassword'};
    my $confirm = $c->req->params->{'confirmPassword'};
    if ($newpass eq $confirm) {
      my $entropy = password_entropy($newpass);
      if ($entropy >= 50) {
        if ($c->authenticate({ username => $c->session->{'user'}, password => $current })) {
          my $usr = $c->model('DB')->resultset('User')->single({username => $c->session->{'user'}});
          $usr->password($newpass);
          $usr->update;
          $c->stash(success_txt => 'Password updated');
        } else {
          $c->stash(error_txt => 'Current password seems to be wrong.');
        }
      } else {
        $c->stash(error_txt => "New password seems weak… (${entropy})");
      }
    } else {
      $c->stash(error_txt => 'Passwords do not match');
    }
  } else {
    $c->stash(error_txt => 'Unknown action '.$action);
  }
  $c->stash(template => 'account/index.tt');
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
