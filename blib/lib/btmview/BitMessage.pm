package btmview::BitMessage;

use strict;
use warnings;
use utf8;
use JSON;
use XML::Simple;
require RPC::XML;
require RPC::XML::Client;
use MIME::Base64;

sub query {
  my ($self, $c, $action, %opts) = @_;

  use Data::Dumper;

  my $apiusername  = $self->{'apiusername'};
  my $apipassword  = $self->{'apipassword'};
  my $apiinterface = $self->{'apiinterface'};
  my $apiport      = $self->{'apiport'};

  my $remote_rpc = 'http://'.$apiusername.':'.$apipassword.'@'.$apiinterface.':'.$apiport ;
  my $rpc = RPC::XML::Client->new($remote_rpc);

  my $is_json = 1;
  my $request;

  if ($action eq 'helloWorld') {
    $is_json = 0;
    $request = RPC::XML::request->new($action, ($opts{'first'}, $opts{'second'}));
  } elsif ($action eq 'add') {
    $is_json = 0;
    $request = RPC::XML::request->new($action, ($opts{'first'}, $opts{'second'}));
  } elsif ($action eq 'statusBar') {
    $request = RPC::XML::request->new($action, $opts{'messageid'});
  } elsif ($action eq 'listAddresses2') {
    $request = RPC::XML::request->new($action);
  } elsif ($action eq 'createRandomAddress') {
    $is_json = 0;
    $request = RPC::XML::request->new($action, encode_base64($opts{'label'}));
  } elsif ($action eq 'createDeterministicAddresses') {
    my $shortBit = RPC::XML::boolean->new($opts{'eighteenByteRipe'});
    $request = RPC::XML::request->new(
      $action,
      (
        encode_base64($opts{'passphrase'}),
        $opts{'numberOfAddresses'},
        $opts{'addressVersionNumber'},
        $opts{'streamNumber'},
        $shortBit,
        $opts{'totalDifficulty'},
        $opts{'smallMessageDifficulty'}
      )
    );
  } elsif ($action eq 'getDeterministicAddress') {
    $request = RPC::XML::request->new($action, (encode_base64($opts{'passphrase'}), $opts{'addressVersionNumber'}, $opts{'streamNumber'}));
  } elsif ($action eq 'getAllInboxMessages') {
    $request = RPC::XML::request->new($action);
  } elsif ($action eq 'getAllInboxMessageIDs') {
    $request = RPC::XML::request->new($action);
  } elsif ($action eq 'getInboxMessageByID') {
    my $readBit = RPC::XML::boolean->new($opts{'readBit'});
    $request = RPC::XML::request->new($action, ($opts{'msgid'}, $readBit));
  } elsif ($action eq 'getSentMessageByAckData') {
    $request = RPC::XML::request->new($action, $opts{'ackData'});
  } elsif ($action eq 'getAllSentMessages') {
    $request = RPC::XML::request->new($action);
  } elsif ($action eq 'getSentMessageByID') {
    $request = RPC::XML::request->new($action, $opts{'msgid'});
  } elsif ($action eq 'getSentMessagesBySender') {
    $request = RPC::XML::request->new($action, $opts{'fromAddress'});
  } elsif ($action eq 'trashMessage') {
    $request = RPC::XML::request->new($action, $opts{'msgid'});
    $is_json = 0;
  } elsif ($action eq 'sendMessage') {
    $is_json = 0;
    $request = RPC::XML::request->new(
      $action,
      ( $opts{'toAddress'},
        $opts{'fromAddress'},
        encode_base64($opts{'subject'}),
        encode_base64($opts{'message'}),
        ($opts{'encodingType'}||2)
      )
    );
  } elsif ($action eq 'sendBroadcast') {
    my $encoding = RPC::XML::int->new($opts{'encodingType'});
    $request = RPC::XML::request->new($action, ($opts{'fromAddress'},encode_base64($opts{'subject'}),encode_base64($opts{'message'}),$encoding));
    $is_json = 0;
  } elsif ($action eq 'getStatus') {
    $request = RPC::XML::request->new($action, $opts{'ackData'});
  } elsif ($action eq 'listSubscriptions') {
    $request = RPC::XML::request->new($action);
  } elsif ($action eq 'addSubscription') {
    $is_json = 0;
    $request = RPC::XML::request->new($action, ($opts{'address'}, encode_base64($opts{'label'})));
  } elsif ($action eq 'deleteSubscription') {
    $is_json = 0;
    $request = RPC::XML::request->new($action, $opts{'address'});
  } elsif ($action eq 'listAddressBookEntries') {
    $request = RPC::XML::request->new($action);
  } elsif ($action eq 'addAddressBookEntry') {
    $is_json = 0;
    $request = RPC::XML::request->new($action, ($opts{'address'}, encode_base64($opts{'label'})));
  } elsif ($action eq 'deleteAddressBookEntry') {
    $is_json = 0;
    $request = RPC::XML::request->new($action, $opts{'address'});
  } elsif ($action eq 'trashSentMessageByAckData') {
    $request = RPC::XML::request->new($action, $opts{'ackData'});
  } elsif ($action eq 'createChan') {
    $is_json = 0;
    $request = RPC::XML::request->new($action, encode_base64($opts{'passphrase'}));
  } elsif ($action eq 'joinChan') {
    $is_json = 0;
    $request = RPC::XML::request->new($action, (encode_base64($opts{'passphrase'}), $opts{'address'}));
  } elsif ($action eq 'leaveChan') {
    $is_json = 0;
    $request = RPC::XML::request->new($action, $opts{'address'});
  } elsif ($action eq 'deleteAddress') {
    $is_json = 0;
    $request = RPC::XML::request->new($action, $opts{'address'});
  } elsif ($action eq 'decodeAddress') {
    $request = RPC::XML::request->new($action, $opts{'address'});
  } else {
    $is_json = 0;
    $request = RPC::XML::request->new($action, ('Hello', 'World'));
  }

  my $answer = $rpc->simple_request($request);

  if ($action eq 'sendMessage') {
    use Data::Dumper;
    $c->log->debug(Dumper($answer));
  }
  my $json;
  if ($is_json) {
    $json = decode_json($answer);
  } else {
    $json->{'answer'} = $answer;
  }
  return $json;
}

1;
