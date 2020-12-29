# NAME

Dist::Zilla::Plugin::CheckForUnwantedFiles - Check for unwanted files

<div>
    <p>
    <img src="https://img.shields.io/badge/perl-5.14+-blue.svg" alt="Requires Perl 5.14+" />
    <img src="https://img.shields.io/badge/coverage-93.6%25-yellow.svg" alt="coverage 93.6%" />
    <a href="https://github.com/Csson/p5-Dist-Zilla-Plugin-CheckForUnwantedFiles/actions?query=workflow%3Amakefile-test"><img src="https://img.shields.io/github/workflow/status/Csson/p5-Dist-Zilla-Plugin-CheckForUnwantedFiles/makefile-test" alt="Build status at Github" /></a>
    </p>
</div>

# VERSION

Version 0.0100, released 2020-12-29.

# SYNOPSIS

In `dist.ini` (though it is more useful in a `PluginBundle`):

    [CheckForUnwantedFiles]
    unwanted_file = .travis.yml
    unwanted_file = .github/

# DESCRIPTION

This plugin checks the development directory (not the build directory) for unwanted files. This is useful when, for instance, switching CI providers, and you don't
want to have the previous provider's configuration files lingering around **and** you are too forgetful to remember to check for them
when doing a new release after the switch.

In other words:

1. Remove the plugin that generates the file from the bundle
2. Add this plugin to the bundle
3. Add the path to the file gets generated as an `unwanted_file`

It is run at the `AfterBuild` stage, and takes one (repeatable) argument: `unwanted_file`. It is a fatal error if any unwanted file is found.
And, despite its name, it works just as well with unwanted directories.

# SOURCE

[https://github.com/Csson/p5-Dist-Zilla-Plugin-CheckForUnwantedFiles](https://github.com/Csson/p5-Dist-Zilla-Plugin-CheckForUnwantedFiles)

# HOMEPAGE

[https://metacpan.org/release/Dist-Zilla-Plugin-CheckForUnwantedFiles](https://metacpan.org/release/Dist-Zilla-Plugin-CheckForUnwantedFiles)

# AUTHOR

Erik Carlsson <info@code301.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2020 by Erik Carlsson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
