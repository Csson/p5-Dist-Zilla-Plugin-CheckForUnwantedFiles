use 5.14.0;
use strict;
use warnings;

package Dist::Zilla::Plugin::CheckForUnwantedFiles;

# ABSTRACT: Check for unwanted files
# AUTHORITY
our $VERSION = '0.0101';

use Moose;
use namespace::autoclean;
use Path::Tiny;
use Types::Standard qw/ArrayRef/;

with qw/
    Dist::Zilla::Role::AfterBuild
/;

has unwanted_file => (
    is => 'ro',
    isa => ArrayRef,
    default => sub { [] },
);

sub mvp_multivalue_args { qw/unwanted_file/ }

sub after_build {
    my $self = shift;
    my $root_path = path('.');

    my @existing_unwanted_paths = ();
    for my $unwanted (@{ $self->unwanted_file }) {
        push @existing_unwanted_paths => $unwanted if $root_path->child($unwanted)->exists;
    }

    if (scalar @existing_unwanted_paths) {
        $self->log('The following unwanted files exist:');
        for my $unwanted (@existing_unwanted_paths) {
            $self->log("* $unwanted");
        }
        $self->log_fatal('Build aborted.');
    }
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=head1 SYNOPSIS

In C<dist.ini> (though it is more useful in a C<PluginBundle>):

    [CheckForUnwantedFiles]
    unwanted_file = .travis.yml
    unwanted_file = .github/

=head1 DESCRIPTION

This plugin checks the development directory (not the build directory) for unwanted files. This is useful when, for instance, switching CI providers, and you don't
want to have the previous provider's configuration files lingering around B<and> you are too forgetful to remember to check for them
when doing a new release after the switch.

It is run at the C<AfterBuild> stage, and takes one (repeatable) argument: C<unwanted_file>. It is a fatal error if any unwanted file is found.
And, despite its name, it works just as well with unwanted directories.

So:

=for :list
1. Remove the plugin that generates the file from the bundle
2. Add this plugin to the bundle
3. Add the path to the file gets generated as an C<unwanted_file>
4. You must delete the unwanted file before the distribution can be built

=cut
