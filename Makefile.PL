#!/usr/gnu/bin/perl -w

use ExtUtils::MakeMaker;

WriteMakefile
(
'clean'				=>
	{
	'FILES'			=> 'blib/* Makefile MANIFEST Getopt-Simple-*'
	},
'dist'				=>
	{
	'COMPRESS'		=> 'gzip',
	'SUFFIX'		=> 'gz'
	},
'DISTNAME'			=> 'Getopt-Simple',
'NAME'				=> 'Getopt::Simple',
'PM'				=>
	{
	'Simple.pm' 	=> '$(INST_LIBDIR)/Simple.pm',
	},
'VERSION_FROM'		=> 'Simple.pm'
);
