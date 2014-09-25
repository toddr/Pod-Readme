package Pod::Readme::Types;

use v5.10.1;

use strict;
use warnings;

use Exporter qw/ import /;
use Type::Tiny;

use version 0.77; our $VERSION = version->declare('v1.0.0_04');

our @EXPORT_OK = qw/ Indentation HeadingLevel TargetName /;

=head1 NAME

Pod::Readme::Types - types used by Pod::Readme

=head1 SYNOPSIS

  use Pod::Readme::Types qw/ Indentation /;

  has verbatim_indent => (
    is      => 'ro',
    isa     => Indentation,
    default => 2,
  );

=head1 DESCRIPTION

This module provides types for use with the modules in L<Pod::Readme>.

It is intended for internal use, although some of these may be useful
for writing plugins (see L<Pod::Readme::Plugin>).

=head1 EXPORTS

None by default. All functions must be explicitly exported.

=head2 C<Indentation>

The indentation level used for verbatim text. Must be an integer
greater than or equal to 2.

=cut

sub Indentation {
    state $type = Type::Tiny->new(
        name       => 'Indentation',
        constraint => sub { $_ =~ /^\d+$/ && $_ >= 2 },
        message => sub { 'must be an integer >= 2' },
    );
    return $type;
}

=head2 C<HeadingLevel>

A heading level, used for plugin headings.

Must be either 1, 2 or 3. (Note that C<=head4> is not allowed, since
some plugins use subheadings.)

=cut

sub HeadingLevel {
    state $type = Type::Tiny->new(
        name       => 'HeadingLevel',
        constraint => sub { $_ =~ /^[123]$/ },
        message    => sub { 'must be an integer between 1 and 3' },
    );
    return $type;
}

=head2 C<TargetName>

A name of a target, e.g. "readme".

=cut

sub TargetName {
    state $type = Type::Tiny->new(
        name       => 'TargetName',
        constraint => sub { $_ =~ /^\w+$/ },
        message    => sub { 'must be an alphanumeric string' },
    );
    return $type;
}

1;