NAME
    "Getopt::Simple" - Provide a simple wrapper around Getopt::Long.

SYNOPSIS
            use Getopt::Simple;

            # Or ...
            # use Getopt::Simple qw($switch);

            my($options) =
            {
            'help' =>
                    {
                    'type'          => '',
                    'env'           => '-',
                    'default'       => '',
    #               'verbose'       => '',  # Not needed on every key.
                    'order'         => 1,
                    },
            'username' =>
                    {
                    'type'          => '=s',                        # As per Getopt::Long.
                    'env'           => '$USER',                     # Help text.
                    'default'       => $ENV{'USER'} || 'RonSavage', # In case $USER is undef.
                    'verbose'       => 'Specify the username on the remote machine',
                    'order'         => 3,                           # Help text sort order.
                    },
            'password' =>
                    {
                    'type'          => '=s',
                    'env'           => '-',
                    'default'       => 'password',
                    'verbose'       => 'Specify the password on the remote machine',
                    'order'         => 4,
                    },
            };

            my($option) = new Getopt::Simple;

            if (! $option -> getOptions($options, "Usage: testSimple.pl [options]") )
            {
                    exit(-1);       # Failure.
            }

            print "username: $option->{'switch'}{'username'}. \n";
            print "password: $option->{'switch'}{'password'}. \n";

            # Or, after 'use Getopt::Simple qw($switch);' ...
            # print "username: $switch->{'username'}. \n";
            # print "password: $switch->{'password'}. \n";

DESCRIPTION
    The "Getopt::Simple" module provides a simple way of specifying:

    *   Command line switches

    *   Type information for switch values

    *   Default values for the switches

    *   Help text per switch

The "getOptions()" function
    The "getOptions()" function takes 4 parameters:

    *   A hash defining the command line switches

    *   A string to display as a help text heading

    *   A Boolean. 0 = (Default) Use case-sensitive switch names. 1 = Ignore
        case

    *   A Boolean. 0 = Return after displaying help. 1 = (Default) Terminate
        with exit(0) after displaying help

The $classRef -> {'switch'} hash reference
    Command line option values are accessed in your code by dereferencing
    the hash reference $classRef -> {'switch'}. Two examples are given
    above, under synopsis.

    Alternately, you can use the hash reference $switch. See below.

The $switch hash reference
    Command line option values are accessed in your code by dereferencing
    the hash reference $switch. Two examples are given above, under
    synopsis.

    Alternately, you can use the hash reference $classRef -> {'switch'}. See
    above.

The "dumpOptions()" function
    "dumpOptions()" prints all your option's keys and their current values.

The "helpOptions()" function
    "helpOptions()" prints nicely formatted help text.

INSTALLATION
    You install "Getopt::Simple", as you would install any perl module
    library, by running these commands:

            perl Makefile.PL
            make
            make test
            make install

    If you want to install a private copy of "Getopt::Simple" in your home
    directory, then you should try to produce the initial Makefile with
    something like this command:

            perl Makefile.PL LIB=~/perl
                    or
            perl Makefile.PL LIB=C:/Perl/Site/Lib

    If, like me, you don't have permission to write man pages into unix
    system directories, use:

            make pure_install

    instead of make install. This option is secreted in the middle of p 414
    of the second edition of the dromedary book.

WARNING re Perl bug
    As always, be aware that these 2 lines mean the same thing, sometimes:

    *   $self -> {'thing'}

    *   $self->{'thing'}

    The problem is the spaces around the ->. Inside double quotes, "...",
    the first space stops the dereference taking place. Outside double
    quotes the scanner correctly associates the $self token with the
    {'thing'} token.

    I regard this as a bug.

REQUIRED MODULES
    *   Exporter

    *   Getopt::Long

RETURN VALUES
    *   "dumpOptions()" returns nothing

    *   "helpOptions()" returns nothing

    *   "getOptions()" returns 0 for failure and 1 for success

AUTHOR
    "Getopt::Simple" was written by Ron Savage *<ron@savage.net.au>* in
    1997.

LICENCE
    Australian copyright (c) 1997-2002 Ron Savage.

            All Programs of mine are 'OSI Certified Open Source Software';
            you can redistribute them and/or modify them under the terms of
            The Artistic License, a copy of which is available at:
            http://www.opensource.org/licenses/index.html
