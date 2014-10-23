package App::PipeFilter::Generic;
BEGIN {
  $App::PipeFilter::Generic::VERSION = '0.001';
}

use Moose;
with qw(
  App::PipeFilter::Role::Flags::Standard
  App::PipeFilter::Role::Opener::GenericIO
);

sub run {
  my $self = shift();

  my $ofh = $self->open_output('-');

  while (defined (my $input_filename = $self->next_input_file())) {
    my $ifh = $self->open_input($input_filename);
    $self->filter_file($ifh, $ofh);
  }

  # Exit value.
  0;
}

sub filter_file {
  my ($self, $ifh, $ofh) = @_;

  my $buffer = "";

  while ($self->read_input($ifh, \$buffer)) {
    next unless my (@input) = $self->decode_input(\$buffer);
    next unless my (@output) = $self->transform(@input);
    print $ofh $_ foreach $self->encode_output(@output);
  }
}

1;

__END__

=head1 NAME

App::PipeFilter::Generic - a generic pipeline filter

=head1 VERSION

version 0.001

=head1 SYNOPSIS

  package App::PipeFilter::JsonToYaml;

  use Moose;

  extends 'App::PipeFilter::Generic';

  with qw(
    App::PipeFilter::Role::Reader::Sysread
    App::PipeFilter::Role::Input::Json
    App::PipeFilter::Role::Transform::None
    App::PipeFilter::Role::Output::Yaml
  );

  1;

=head1 DESCRIPTION

App::PipeFilter::Generic is a generic shell pipeline filter.  It is
designed to be customized by subclassing and consuming roles that
implement specific behaviors.

For example, L<App::PipeFilter::JsonToYaml> extends the generic
pipeline filter with a role to read data in large chunks, a role to
parse that input as a stream of JSON objects, a role that doesn't
alter the data that has been read, and a role to format the output as
YAML.

=head1 PUBLIC METHODS

=head2 decode_input SCALAR_REF

decode_input() accepts a reference to an input buffer containing raw
octets from some input stream.  It deserializes as many input records
as it can from the buffer.  It removes the deserialized octets from
the buffer, leaving any unused data for another time.  decode_input()
returns an array of the deserialized data structures.

This method is usually implemented by Input roles such as
L<App::PipeFiter::Role::Input::Json>.  See that module for a sample
implementation.

=head2 encode_output ARRAY

encode_output() accepts an array of Perl data structures to be output.
It returns an array of serialized data, one element for each input
data structure.

This method is usually implemented by Output roles such as
L<App::PipeFilter::Role::Output::Yaml>.  See that module for a sample
implementation.

=head2 filter_file IN_FILEHANDLE, OUT_FILEHANDLE

filter_file() translates one input file to output.  IN_FILEHANDLE is
an open filehandle to the source data.  OUT_FILEHANDLE is an open
filehandle to the output data sink.

filter_file() invokes read_input(), decode_input(), transform() and
encode_output() until a single input file is completely filtered.

=head2 next_input_file

next_input_file() returns the name of the next file to read.
App::PipeFilter::Generic's run() method uses it to iterate over the
list of input files provided on the command line.

next_input_file() is implemented in
L<App::PipeFilter::Role::Flags::Standard>.

=head2 open_input FILENAME

open_input() opens a named file and returns the opened filehandle to
it.  The special file name "-" opens STDIN.

App::PipeFilter::Generic's run() method uses open_input() to open the
files named by next_input_file().

open_input() is implemented in Opener roles such as
L<App::PipeFilter::Role::Opener::GenericInput>.  See that module for a
sample implementation.

=head2 open_output FILENAME

open_output() opens a named file and returns the opened filehandle to
it.  The special file name "-" opens STDOUT.

App::PipeFilter::Generic's run() method uses open_output() to open
standard output for writing results.

open_output() is implemented in Opener roles such as
L<App::PipeFilter::Role::Opener::GenericOutput>.  See that module for
a sample implementation.

=head2 run

run() opens standard output using open_output("-").  It then calls
next_input_file() to iterate through all the input file names provided
on the command line.  Each input file is opened with open_input().
The resulting input and output file handles are passed to
filter_file(), which filters the entire file.

run() is implemented in App::PipeFilter::Generic.

=head2 transform ARRAY

transform() accepts an array of data references.  It returns another
array of data references after performing some transformative function
on each one.  The resulting array may have greater or fewer items than
the input array.  transform() may return an empty array if all input
records are to be discarded.

Common data transformations may be implemented in Transform roles,
such as L<App::PipeFilter::Role::Transform::None>.  Most of the time,
however, individual utility classes like L<App::PipeFilter::JsonMap>
define their own transformations.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::Generic

L<App::PipeFilter::Generic::Json> consumes common roles for filters
that read and write streams of JSON objects.

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and utilities included in the project.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::Generic
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::Generic
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab

=cut

# vim: ts=2 sw=2 expandtab