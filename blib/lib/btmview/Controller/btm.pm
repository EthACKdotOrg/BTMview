package btmview::Controller::btm;
use Moose;
use namespace::autoclean;
use utf8;

use btmview::BitMessage;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

btmview::Controller::btm - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  $c->response->body('Matched btmview::Controller::btm in btm.');
}
sub api :Local :Ags(1) {
  my ( $self, $c, $command ) = @_;

  my %opts;
  foreach (keys($c->req->params)) {
    $opts{$_} = $c->req->params->{$_};
  }
  my $answer = btmview::BitMessage::query($self, $c, $command, %opts);

  $c->stash(%{$answer});
  
  $c->component('View::JSON')->encoding('utf-8');
  $c->forward('View::JSON');
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
