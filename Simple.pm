package Getopt::Simple;

# Name:
#	Getopt::Simple.
#
# Documentation:
#	POD-style documentation is at the end. Extract it with pod2html.*.
#
# Tabs:
#	4 spaces || die.
#
# Author:
#	Ron Savage	rpsavage@ozemail.com.au.
#	1.00	19-Aug-97	Initial version.
#	1.10	13-Oct-97	Add arrays of switches (eg '=s@').
#	1.20	 3-Dec-97	Add 'Help' on a per-switch basis.
#	1.30	11-Dec-97	Change 'Help' to 'verbose'. Make all hash keys lowercase.
# --------------------------------------------------------------------------

use strict;
no strict 'refs';

use vars qw(@EXPORT @EXPORT_OK @ISA);
use vars qw($fieldWidth $switch $VERSION);

use Exporter();
use Getopt::Long;

@ISA		= qw(Exporter);
@EXPORT		= qw();
@EXPORT_OK	= qw($switch);	# An alias for $self -> {'switch'}.

# --------------------------------------------------------------------------

$fieldWidth	= 15;
$VERSION	= '1.30';

# --------------------------------------------------------------------------

sub byOrder
{
	my($self) = @_;

	${$self -> {'default'} }{$a}{'order'} <=> ${$self -> {'default'} }{$b}{'order'};
}

# --------------------------------------------------------------------------

sub dumpOptions
{
	my($self) = @_;

	print 'Option', ' ' x ($fieldWidth - length('Option') ), "Value\n";

	for (sort byOrder keys(%{$self -> {'switch'} }) )
	{
		if (ref(${$self->{'switch'} }{$_}) eq 'ARRAY')
		{
			print "-$_", ' ' x ($fieldWidth - (1 + length) );
			my($i);
			print '(';
			for ($i = 0; $i <= $#{${$self->{'switch'} }{$_} }; $i++)
			{
				print "${${$self->{'switch'} }{$_} }[$i]";
				print ', ' if ($i < $#{${$self->{'switch'} }{$_} });
			}
			print ")\n";
		}
		else
		{
			print "-$_", ' ' x ($fieldWidth - (1 + length) ), "${$self->{'switch'} }{$_}\n";
		}
	}

	print "\n";

}	# End of dumpOptions.

# --------------------------------------------------------------------------
# Return:
#	0 -> Error.
#	1 -> Ok.

sub getOptions
{
	push(@_, 0) if ($#_ == 2);	# Default for $ignoreCase is 0.
	push(@_, 1) if ($#_ == 3);	# Default for $helpThenExit is 1.

	my($self, $default, $helpText, $ignoreCase, $helpThenExit) = @_;

	$self -> {'default'}		= $default;
	$self -> {'helpText'}		= $helpText;
	$Getopt::Long::ignorecase	= $ignoreCase;

	for (keys(%{$self -> {'default'} }) )
	{
		push(@{$self -> {'type'} }, "$_${$self -> {'default'} }{$_}{'type'}");
	}

	my($result) = &GetOptions($self -> {'switch'}, @{$self -> {'type'} });

	if (${$self -> {'switch'} }{'help'})
	{
		$self -> helpOptions();
		exit(0) if ($helpThenExit);
	}

	for (keys(%{$self -> {'default'} }) )
	{
		if (ref(${$self->{'switch'} }{$_}) eq 'ARRAY')
		{
			${$self -> {'switch'} }{$_} = [split(/\s+/, ${$self -> {'default'} }{$_}{'default'})] if (! ${$self -> {'switch'} }{$_});
		}
		else
		{
			${$self -> {'switch'} }{$_} = ${$self -> {'default'} }{$_}{'default'} if (! ${$self -> {'switch'} }{$_});
		}
	}

	$result;

}	# End of getOptions.

# --------------------------------------------------------------------------

sub helpOptions
{
	my($self) = @_;

	print "$self->{'helpText'}\n" if ($self -> {'helpText'});

	print 'Option', ' ' x ($fieldWidth - length('Option') ),
		'Env', ' ' x ($fieldWidth - length('env') ),
		"Default\n";

	for (sort byOrder keys(%{$self -> {'default'} }) )
	{
		print "-$_", ' ' x ($fieldWidth - (1 + length) ),
			"${$self->{'default'} }{$_}{'env'}",
			' ' x ($fieldWidth - length(${$self -> {'default'} }{$_}{'env'}) );

		if (ref(${$self->{'default'} }{$_}{'default'}) eq 'ARRAY')
		{
			my($i);
			print '(';
			for ($i = 0; $i <= $#{${$self->{'default'} }{$_}{'default'} }; $i++)
			{
				print "${${$self->{'default'} }{$_}{'default'} }[$i]";
				print ', ' if ($i < $#{${$self->{'default'} }{$_}{'default'} });
			}
			print ")\n";
		}
		else
		{
			print "${$self->{'default'} }{$_}{'default'}\n";
		}

		print "\t${$self->{'default'} }{$_}{'verbose'}\n"
			if (defined(${$self -> {'default'} }{$_}{'verbose'}) &&
				${$self -> {'default'} }{$_}{'verbose'} ne '');
	}

	print "\n";

}	# End of helpOptions.

#-------------------------------------------------------------------

sub new
{
	my($class)				= @_;
	my($self)				= {};
	$self -> {'default'}	= {};
	$self -> {'helpText'}	= '';
	$self -> {'switch'}		= {};
	$switch					= $self -> {'switch'};	 # An alias for $self -> {'switch'}.
	$self -> {'type'}		= ();

	return bless $self, $class;

}	# End of new.

# --------------------------------------------------------------------------

1;

__END__

=head1 NAME

C<Getopt::Simple> - Provide a simple wrapper around Getopt::Long.

=head1 SYNOPSIS

	use Getopt::Simple;

	# Or ...
	# use Getopt::Simple qw($switch);

	my($options) =
	{
	'help' =>
		{
		'type'		=> '',
		'env'		=> '-',
		'default'	=> '',
#		'verbose'	=> '',	# Not needed on every key.
		'order'		=> 1,
		},
	'username' =>
		{
		'type'		=> '=s',			# As per Getopt::Long.
		'env'		=> '$USER',			# Help text.
		'default'	=> $ENV{'USER'} || 'RonSavage',	# In case $USER is undef.
		'verbose'	=> 'Specify the username on the remote machine',
		'order'		=> 3,				# Help text sort order.
		},
	'password' =>
		{
		'type'		=> '=s',
		'env'		=> '-',
		'default'	=> 'password',
		'verbose'	=> 'Specify the password on the remote machine',
		'order'		=> 4,
		},
	};

	my($option) = new Getopt::Simple;

	if (! $option -> getOptions($options, "Usage: testSimple.pl [options]") )
	{
		exit(-1);	# Failure.
	}

	print "username: $option->{'switch'}{'username'}. \n";
	print "password: $option->{'switch'}{'password'}. \n";

	# Or, after 'use Getopt::Simple qw($switch);' ...
	# print "username: $switch->{'username'}. \n";
	# print "password: $switch->{'password'}. \n";

=head1 DESCRIPTION

The C<Getopt::Simple> module provides a simple way of specifying:

=over 4

=item *

Command line switches

=item *

Type information for switch values

=item *

Default values for the switches

=item *

Help text per switch

=back

=head1 The C<getOptions()> function

The C<getOptions()> function takes 4 parameters:

=over 4

=item *

A hash defining the command line switches

=item *

A string to display as a help text heading

=item *

A Boolean. 0 = (Default) Use case-sensitive switch names. 1 = Ignore case

=item *

A Boolean. 0 = Return after displaying help. 1 = (Default) Terminate with exit(0)
after displaying help

=back

=head1 The $classRef -> {'switch'} hash reference

Command line option values are accessed in your code by dereferencing
the hash reference $classRef -> {'switch'}. Two examples are given above,
under synopsis.

Alternately, you can use the hash reference $switch. See below.

=head1 The $switch hash reference

Command line option values are accessed in your code by dereferencing
the hash reference $switch. Two examples are given above,
under synopsis.

Alternately, you can use the hash reference $classRef -> {'switch'}. See above.

=head1 The C<dumpOptions()> function

C<dumpOptions()> prints all your option's keys and their current values.

=head1 The C<helpOptions()> function

C<helpOptions()> prints nicely formatted help text.

=head1 WARNING re Perl bug

As always, be aware that these 2 lines mean the same thing, sometimes:

=over 4

=item *

$self -> {'thing'}

=item *

$self->{'thing'}

=back

The problem is the spaces around the ->. Inside double quotes, "...", the
first space stops the dereference taking place. Outside double quotes the
scanner correctly associates the $self token with the {'thing'} token.

I regard this as a bug.

=head1 REQUIRED MODULES

=over 4

=item *

Exporter

=item *

Getopt::Long

=back

=head1 RETURN VALUES

=over 4

=item *

C<dumpOptions()> returns nothing

=item *

C<helpOptions()> returns nothing

=item *

C<getOptions()> returns 0 for failure and 1 for success

=back

=head1 AUTHOR

C<Getopt::Simple> was written by Ron Savage I<E<lt>rpsavage@ozemail.com.auE<gt>> in 1997.

=head1 LICENCE

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.
