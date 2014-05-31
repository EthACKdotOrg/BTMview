package btmview::Controller::btmapi;
use Moose;
use namespace::autoclean;
use utf8;

use JSON::RPC;
use Scalar::Util qw(looks_like_number);
use MIME::Base64;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

btmview::Controller::BTMapi - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut
sub auto :Private {
  my ( $self, $c ) = @_;

  if (!$c->user_exists) {
    $c->response->redirect('/');
    return 0;
  } else {
    my $remote_rpc = 'http://'.$self->{'apiusername'}.':'.$self->{'apipassword'}.'@'.$self->{'apiinterface'}.':'.$self->{'apiport'} ;
    my $rpc = JSON::RPC->new($remote_rpc);
    $c->stash(rpc => $rpc);
    return 1;
  }
}

sub helloWorld :Local :Args(2) {
  my ( $self, $c, $first, $second ) = @_;
  my $rpc = $c->stash->{'rpc'};

  my $answer = $rpc->call('helloWorld', ($first, $second) );

  $c->stash(rpc => $answer); 
  $c->component('View::JSON')->encoding('utf-8');
  $c->forward('View::JSON');
}
sub add :Local :Args(2) {
  my ( $self, $c, $int1, $int2 ) = @_;
  my $rpc = $c->stash->{'rpc'};

  my $answer;
  if (looks_like_number($int1) && looks_like_number($int2)) {
    $answer = $rpc->call('helloWorld', (int($int1), int($int2)) );
  } else {
    $answer = 'error'
  }

  $c->stash(rpc => $answer); 
  $c->component('View::JSON')->encoding('utf-8');
  $c->forward('View::JSON');
}
sub statusBar :Local :Args(0) {
  my ( $self, $c ) = @_;
  $c->response->body('Not implemented - no use');
}
sub listAddresses2 :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};

  my $answer = $rpc->call('listAddresses2');
  $c->stash(rpc => $answer); 
  $c->component('View::JSON')->encoding('utf-8');
  $c->forward('View::JSON');
}
sub createRandomAddress :Local :Args(1) {
  my ( $self, $c, $label ) = @_;
  $label = encode_base64($label);
  my $rpc = $c->stash->{'rpc'};

  my $answer = $rpc->call('createRandomAddress', $label);
  $c->response->body($answer);
}
sub createDeterministicAddresses :Local :Args(1) {
  my ( $self, $c, $passphrase ) = @_;
  my $many = $c->req->params->{'many'} || 1;

  $passphrase = encode_base64($passphrase);
  my $rpc = $c->stash->{'rpc'};

  my $answer = $rpc->call('createDeterministicAddresses', ($passphrase, $many));
  $c->response->body($answer);
}
sub getDeterministicAddress :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub getAllInboxMessages :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};

  my $answer = $rpc->call('getAllInboxMessages');
  $c->response->body($answer);
}
sub getAllInboxMessageIDs :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub getInboxMessageByID :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub getSentMessageByAckData :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub getAllSentMessages :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub getSentMessageByID :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub getSentMessagesBySender :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub trashMessage :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub sendMessage :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub sendBroadcast :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub getStatus :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub listSubscriptions :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub addSubscription :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub deleteSubscription :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub listAddressBookEntries :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};

  my $answer = $rpc->call('listAddressBookEntries');

  $c->response->body($answer);
}
sub addAddressBookEntry :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub deleteAddressBookEntry :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub trashSentMessageByAckData :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub createChan :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub joinChan :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub leaveChan :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub deleteAddress :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
}
sub decodeAddress :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $rpc = $c->stash->{'rpc'};
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
