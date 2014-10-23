package App::PipeFilter::Role::Opener::GenericIO;
BEGIN {
  $App::PipeFilter::Role::Opener::GenericIO::VERSION = '0.001';
}

use Moose::Role;

with qw(
  App::PipeFilter::Role::Opener::GenericInput
  App::PipeFilter::Role::Opener::GenericOutput
);

1;

__END__

=head1 NAME


=head1 VERSION

version 0.001
App::PipeFilter::Role::Opener::GenericIO - generic methods to open
input and output filesj

=head1 SYNOPSIS

This is not a complete module.

  package App::PipeFilter::Generic;

  use Moose;
  with qw(
    App::PipeFilter::Role::Flags::Standard
    App::PipeFilter::Role::Opener::GenericIO
  );

  ... implementation goes here ....

  1;

=head1 DESCRIPTION

App::PipeFilter::Role::Opener::GenericIO provides generic open_input()
and open_output() methods for L<App::PipeFilter::Generic> and other
pipeline filter implementations.

It comprises L<App::PipeFilter::Role::Opener::GenericInput> and
L<App::PipeFilter::Role::Opener::GenericOutput>.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::Role::Opener::GenericIO

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and utilities included in the project.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::Role::Opener::GenericIO
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::Role::Opener::GenericIO
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab