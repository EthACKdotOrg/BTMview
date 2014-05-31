package btmview::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
  TEMPLATE_EXTENSION => '.tt',
  ENCODING           => 'utf-8',
  render_die         => 1,
  expose_methods     => ['get_rel',]
);

=head1 NAME

btmview::View::HTML - TT View for btmview

=head1 DESCRIPTION

TT View for btmview.

=head1 SEE ALSO

L<btmview>

=head2 get_rel
return url to file with mtime
=cut
sub get_rel {
  my ( $self, $c, $file ) = @_;
  my $time = 100020;
  eval {
    $time = stat('root/static/'.$file)->mtime;
  };
  #return $file.'?mtime='.int($time);
  return '/static/'.int($time).$file;
}


=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
